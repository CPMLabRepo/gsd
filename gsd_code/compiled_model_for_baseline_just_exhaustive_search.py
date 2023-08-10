from pddl.logic import Predicate, constants, variables
from pddl.core import Domain, Problem, Action, Requirements
from pddl.formatter import problem_to_string_for_cost_based_init_state, domain_to_string_for_cost_based_init_state
from pddl import parse_domain, parse_problem

from pddl.logic.effects import When, AndEffect
from pddl.logic.base import Not, And

from utils import get_plan

import copy

import sys, os, csv
import argparse

import time
import itertools

# TODO: Assuming fully grounded domains

ACTION_TEMPLATE = """
    (:action {action_name}
        :parameters ()
        :precondition (and {preconditions})
        :effect (and {effects}
            (increase (total-cost) {cost})
        )
    )
"""

def find_all_individual_designs( path_to_human_problem, path_to_robot_problem):
    # Check if the optional argument was provided
    if path_to_robot_problem is None:
        path_to_robot_problem = path_to_human_problem

    robot_problem = parse_problem(path_to_robot_problem)
    human_problem = parse_problem(path_to_human_problem)


    # Find the set of initial states that are missing from the robot problem
    missing_init_preds = []
    for init_pred in robot_problem.init:
        if init_pred not in human_problem.init:
            missing_init_preds.append(Predicate(init_pred.name))

    # Make a design for each missing initial state predicate
    designs = []
    for missing_init_pred in missing_init_preds:
        designs.append("d_" + str(missing_init_pred.name))

    return designs


def find_number_of_fluents( path_to_human_domain):
    # Check if the optional argument was provided
    human_domain = parse_domain(path_to_human_domain)
    return len(human_domain.predicates)

def calculate_min_gsd(path_to_human_domain, path_to_human_problem, path_to_robot_domain, path_to_robot_problem, designs):
    # calculate the max gsd for the given problem pair

    # Check if the optional argument was provided
    if path_to_robot_problem is None:
        path_to_robot_problem = path_to_human_problem

    robot_domain = parse_domain(path_to_robot_domain)
    robot_problem = parse_problem(path_to_robot_problem)

    human_domain = parse_domain(path_to_human_domain)
    human_problem = parse_problem(path_to_human_problem)

    ## Merge Predicates
    # create a predicate to capture robot failures

    list_h_preds = list(human_domain.predicates)
    list_r_preds = list(robot_domain.predicates)

    predicate_map = {}

    # change robot predicates' names: add "r_"
    for pred in list_r_preds:
        pred._name = "r_" + str(pred.name)
        predicate_map[pred.name] = pred

    # merged domain's predicates
    merged_preds = list_h_preds + list_r_preds
    design_changes = []
    for design in designs:
        design_changes.append(design.replace("d_", ""))
    # Find the set of initial states that are missing from the robot problem
    new_human_init_preds = []
    for init_pred in human_problem.init:
        new_human_init_preds.append(init_pred)
    for new_pred in design_changes:
        new_human_init_preds.append(Predicate(new_pred))

    # Make a design for each missing initial state predicate

    other_predicates = []
    other_predicates.append(Predicate("robot_can_act"))
    other_predicates.append(Predicate("human_can_act"))

    # a check predicate for each of the human predicate
    check_preds = []
    for pred in list_h_preds:
        check_preds.append(Predicate("check_" + str(pred.name)))

    complete_set_of_predicates = merged_preds + other_predicates + check_preds

    ## Merge Actions
    list_h_actions = list(human_domain.actions)
    list_r_actions = list(robot_domain.actions)

    new_human_action = []
    # Add human_can_act to all human action preconditions
    for h_action in list_h_actions:
        new_human_action.append(Action(
            h_action.name,
            parameters=h_action.parameters,
            precondition=And(Predicate("human_can_act"), h_action.precondition),
            effect=h_action.effect
        ))

    # Have a flip action that checks whether human goal is met and then flips human_can_act to robot_can_act
    flip_human_action = Action(
        "flip_human",
        parameters=[],
        precondition=And(Predicate("human_can_act"), human_problem.goal),
        effect=And(Not(Predicate("human_can_act")), Predicate("robot_can_act"))
    )

    # For each robot action add "r_" to the action name and every predicate in the definition
    new_robot_action = []
    for r_action in list_r_actions:
        r_action._name = "r_" + str(r_action.name)
        if type(r_action.precondition) is not And:
            r_action.precondition._name = "r_" + str(r_action.precondition.name)
        else:
            for prec in r_action.precondition.operands:
                prec._name = "r_" + str(prec.name)
        for eff in r_action.effect.operands:
            if type(eff) is Predicate:
                eff._name = "r_" + str(eff.name)
            elif type(eff) is Not:
                eff.argument._name = "r_" + str(eff.argument._name)
        # Add robot_can_act to all robot action preconditions
        previous_prec = r_action.precondition
        new_robot_action.append(Action(
            r_action.name,
            parameters=r_action.parameters,
            precondition=And(Predicate("robot_can_act"), r_action.precondition),
            effect=r_action.effect
        ))

    # Add a flip robot can action action that checks whether robot goal is met and then deletes robot_can_act
    # change the predicates in the original robot goals to the new robot predicates
    new_robot_goal = []
    for pred in robot_problem.goal.operands:
        new_robot_goal.append(predicate_map["r_" + str(pred.name)])
    new_robot_goal = And(*new_robot_goal)

    flip_robot_action = Action(
        "flip_robot",
        parameters=[],
        precondition=And(Predicate("robot_can_act"), new_robot_goal),
        effect=And(Not(Predicate("robot_can_act")))
    )

    # create check action definition strings for each human predicate that check whether the corresponding robot predicate is true or false
    # If the values match then it make check predicate corresponding to that predicate true
    check_actions = []
    for pred in list_h_preds:
        check_actions.append(ACTION_TEMPLATE.format(action_name="check_act" + str(pred.name), preconditions="(r_" + str(
            pred.name) + ") (" + pred.name + ") (not (robot_can_act)) (not (human_can_act))",
                                                    effects="(check_" + str(pred.name) + ")", cost="0"))
        check_actions.append(ACTION_TEMPLATE.format(action_name="check_act_not_" + str(pred.name),
                                                    preconditions="(not (r_" + str(
                                                        pred.name) + ")) (not (" + pred.name + ")) (not (robot_can_act)) (not (human_can_act))",
                                                    effects="(check_" + str(pred.name) + ")", cost="0"))
        check_actions.append(ACTION_TEMPLATE.format(action_name="check_disagree_act1" + str(pred.name),
                                                    preconditions="(not (r_" + str(
                                                        pred.name) + ")) (" + pred.name + ") (not (robot_can_act)) (not (human_can_act))",
                                                    effects="(check_" + str(pred.name) + ")", cost="10"))
        check_actions.append(ACTION_TEMPLATE.format(action_name="check_disagree_act2" + str(pred.name),
                                                    preconditions=" (r_" + str(
                                                        pred.name) + ") (not (" + pred.name + ")) (not (robot_can_act)) (not (human_can_act))",
                                                    effects="(check_" + str(pred.name) + ")", cost="10"))

    all_actions = new_human_action + list_r_actions + [flip_human_action, flip_robot_action]  # + check_actions

    # initial state includes the original human initial state, robot initial state in new predicates, and unused design predicate

    for robot_init in list(robot_problem.init):
        robot_init._name = "r_" + robot_init._name

    merged_inits_for_problem = new_human_init_preds + list(robot_problem.init) + [Predicate("human_can_act")]
    new_goal = And(*check_preds)

    # Create the new domain and problem
    new_domain = Domain(
        name="merged_domain",
        requirements=[":strips", ":typing", ":action-costs"],
        types=list(human_domain.types),
        constants=list(human_domain.constants),
        predicates=complete_set_of_predicates,
        actions=all_actions
    )

    new_problem = Problem(
        name="merged_problem",
        domain=new_domain,
        objects=list(human_problem.objects),
        init=merged_inits_for_problem,
        goal=new_goal
    )
    # write the new domain and problem file in /tmp/
    domain_str = domain_to_string_for_cost_based_init_state(new_domain, action_str="\n".join(check_actions)).lower()
    problem_str = problem_to_string_for_cost_based_init_state(new_problem).lower()
    with open("/tmp/merged_domain.pddl", "w") as f:
        f.write(domain_str)
    with open("/tmp/merged_problem.pddl", "w") as f:
        f.write(problem_str)

    return "/tmp/merged_domain.pddl", "/tmp/merged_problem.pddl"

def find_max_gsd(path_to_human_domain, path_to_human_problem, path_to_robot_domain, path_to_robot_problem, designs):
    #calculate the max gsd for the given problem pair

    # Check if the optional argument was provided
    if path_to_robot_problem is None:
        path_to_robot_problem = path_to_human_problem



    robot_domain = parse_domain(path_to_robot_domain)
    robot_problem = parse_problem(path_to_robot_problem)

    human_domain = parse_domain(path_to_human_domain)
    human_problem = parse_problem(path_to_human_problem)


    ## Merge Predicates
    #create a predicate to capture robot failures

    list_h_preds = list(human_domain.predicates)
    list_r_preds = list(robot_domain.predicates)

    predicate_map = {}

    #change robot predicates' names: add "r_"
    for pred in list_r_preds:
        pred._name = "r_" + str(pred.name)
        predicate_map[pred.name] = pred

    #merged domain's predicates
    merged_preds = list_h_preds + list_r_preds
    design_changes = []
    for design in designs:
        design_changes.append(design.replace("d_", ""))
    # Find the set of initial states that are missing from the robot problem
    new_human_init_preds = []
    for init_pred in human_problem.init:
        new_human_init_preds.append(init_pred)
    for new_pred in design_changes:
        new_human_init_preds.append(Predicate(new_pred))


    # Make a design for each missing initial state predicate

    other_predicates = []
    other_predicates.append(Predicate("robot_can_act"))
    other_predicates.append(Predicate("human_can_act"))

    # a check predicate for each of the human predicate
    check_preds = []
    for pred in list_h_preds:
        check_preds.append(Predicate("check_" + str(pred.name)))

    complete_set_of_predicates = merged_preds +  other_predicates + check_preds

    ## Merge Actions
    list_h_actions = list(human_domain.actions)
    list_r_actions = list(robot_domain.actions)

    new_human_action =[]
    # Add human_can_act to all human action preconditions
    for h_action in list_h_actions:
        new_human_action.append(Action(
            h_action.name,
            parameters = h_action.parameters,
            precondition = And(Predicate("human_can_act"), h_action.precondition),
            effect = h_action.effect
        ))

    # Have a flip action that checks whether human goal is met and then flips human_can_act to robot_can_act
    flip_human_action = Action(
        "flip_human",
        parameters = [],
        precondition = And(Predicate("human_can_act"), human_problem.goal),
        effect = And(Not(Predicate("human_can_act")), Predicate("robot_can_act"))
    )

    # For each robot action add "r_" to the action name and every predicate in the definition
    new_robot_action = []
    for r_action in list_r_actions:
        r_action._name = "r_" + str(r_action.name)
        if type(r_action.precondition) is not And:
            r_action.precondition._name = "r_" + str(r_action.precondition.name)
        else:
            for prec in r_action.precondition.operands:
                prec._name = "r_" + str(prec.name)
        for eff in r_action.effect.operands:
            if type(eff) is Predicate:
                eff._name = "r_" + str(eff.name)
            elif type(eff) is Not:
                eff.argument._name = "r_" + str(eff.argument._name)
        # Add robot_can_act to all robot action preconditions
        previous_prec = r_action.precondition
        new_robot_action.append(Action(
            r_action.name,
            parameters = r_action.parameters,
            precondition = And(Predicate("robot_can_act"), r_action.precondition),
            effect = r_action.effect
        ))

   # Add a flip robot can action action that checks whether robot goal is met and then deletes robot_can_act
    # change the predicates in the original robot goals to the new robot predicates
    new_robot_goal = []
    for pred in robot_problem.goal.operands:
        new_robot_goal.append(predicate_map["r_" + str(pred.name)])
    new_robot_goal = And(*new_robot_goal)

    flip_robot_action = Action(
        "flip_robot",
        parameters = [],
        precondition = And(Predicate("robot_can_act"), new_robot_goal),
        effect = And(Not(Predicate("robot_can_act")))
    )


    # create check action definition strings for each human predicate that check whether the corresponding robot predicate is true or false
    # If the values match then it make check predicate corresponding to that predicate true
    check_actions = []
    for pred in list_h_preds:
        check_actions.append(ACTION_TEMPLATE.format(action_name="check_act" + str(pred.name),preconditions="(r_" + str(pred.name)+") ("+pred.name+") (not (robot_can_act)) (not (human_can_act))", effects="(check_" + str(pred.name)+")", cost="10"))
        check_actions.append(ACTION_TEMPLATE.format(action_name="check_act_not_" + str(pred.name),preconditions="(not (r_" + str(pred.name)+")) (not ("+pred.name+")) (not (robot_can_act)) (not (human_can_act))", effects="(check_" + str(pred.name)+")", cost="10"))
        check_actions.append(ACTION_TEMPLATE.format(action_name="check_disagree_act1" + str(pred.name),preconditions="(not (r_" + str(pred.name)+")) ("+pred.name+") (not (robot_can_act)) (not (human_can_act))", effects="(check_" + str(pred.name)+")", cost="0"))
        check_actions.append(ACTION_TEMPLATE.format(action_name="check_disagree_act2" + str(pred.name),preconditions=" (r_" + str(pred.name)+") (not ("+pred.name+")) (not (robot_can_act)) (not (human_can_act))", effects="(check_" + str(pred.name)+")", cost="0"))


    all_actions = new_human_action + list_r_actions +  [flip_human_action, flip_robot_action] #+ check_actions

    # initial state includes the original human initial state, robot initial state in new predicates, and unused design predicate

    for robot_init in list(robot_problem.init):
        robot_init._name = "r_" + robot_init._name

    merged_inits_for_problem = new_human_init_preds + list(robot_problem.init) + [Predicate("human_can_act")]
    new_goal = And(*check_preds)

    # Create the new domain and problem
    new_domain = Domain(
        name = "merged_domain",
        requirements = [":strips", ":typing", ":action-costs"],
        types = list(human_domain.types),
        constants = list(human_domain.constants),
        predicates = complete_set_of_predicates,
        actions = all_actions
    )

    new_problem = Problem(
        name = "merged_problem",
        domain = new_domain,
        objects = list(human_problem.objects),
        init = merged_inits_for_problem,
        goal = new_goal
    )
    # write the new domain and problem file in /tmp/
    domain_str = domain_to_string_for_cost_based_init_state(new_domain, action_str = "\n".join(check_actions)).lower()
    problem_str = problem_to_string_for_cost_based_init_state(new_problem).lower()
    with open("/tmp/merged_domain.pddl", "w") as f:
        f.write(domain_str)
    with open("/tmp/merged_problem.pddl", "w") as f:
        f.write(problem_str)

    return "/tmp/merged_domain.pddl", "/tmp/merged_problem.pddl"



if __name__ == '__main__':
    # Create an argument parser
    parser = argparse.ArgumentParser(description='Script to process input paths')

    # Add arguments for the paths
    parser.add_argument('-h_d', '--human_domain', help='Path to human domain file', required=True)
    parser.add_argument('-h_i', '--human_problem', help='Path to human problem file', required=True)

    parser.add_argument('-r_d', '--robot_domain', help='Path to robot domain file', required=True)
    parser.add_argument('-r_i', '--robot_problem', help='Path to robot problem file')
    parser.add_argument('-d_c', '--design_count', help='number of designs')

    # Parse the command-line arguments
    args = parser.parse_args()

    path_to_human_domain = args.human_domain
    path_to_robot_domain = args.robot_domain

    # for now, it is same for both human and robot
    path_to_human_problem = args.human_problem
    path_to_robot_problem = args.robot_problem

    # Check if the optional argument was provided
    if path_to_robot_problem is None:
        path_to_robot_problem = path_to_human_problem

    if args.design_count is None:
        design_count = 1
    else:
        design_count = int(args.design_count)

    all_possible_designs = find_all_individual_designs(path_to_human_problem,path_to_robot_problem)

    # find all subsets of the designs with size less than or equal to design_count
    all_possible_designs = list(all_possible_designs)
    all_design_sets = []
    for i in range(0, design_count+1):
        all_design_sets += list(itertools.combinations(all_possible_designs, i))

    total_fluents = find_number_of_fluents(path_to_human_domain)
    all_designs_found = False
    found_designs = []
    best_designs = None
    best_divergence = 10000000
    no_of_design_found = 0
    total_time = time.time()
    for design_set in all_design_sets:
        start_design_time = time.time()
        dom_file, prob_file = calculate_min_gsd(path_to_human_domain, path_to_human_problem, path_to_robot_domain, path_to_robot_problem, design_set)
        plan, cost = get_plan(dom_file, prob_file)
        print ("LOG>>> Time taken to find design and min: ", time.time() - start_design_time)
        if len(plan) == 0:
            min_divergence = total_fluents
        else:
            check_disagreements = []
            for action in plan:
                if "check_disagree_act" in action:
                    check_disagreements.append(action)
            min_divergence = len(check_disagreements)
        print ("Min divergence count: ", min_divergence)
        print ("design set: ", design_set)
        if min_divergence == 0:
            start_time_for_max = time.time()
            max_dom_file, max_prob_file = find_max_gsd(path_to_human_domain, path_to_human_problem, path_to_robot_domain, path_to_robot_problem, design_set)
            plan, cost = get_plan(max_dom_file, max_prob_file)
            print ("LOG>>> Time taken to find max: ", time.time() - start_time_for_max)
            if len(plan) == 0:
                print("IMPORTANT ERROR: Something went wrong!!!")
                exit(1)
            check_disagreements = []
            for action in plan:
                if "check_disagree_act" in action:
                    check_disagreements.append(action)
            print ("LOG>>> max Divergence count: ", len(check_disagreements))
            if best_divergence > len(check_disagreements):
                best_divergence = len(check_disagreements)
                best_designs = design_set
    print("LOG>>> Total time taken: ", time.time() - total_time)
    print("LOG>>> No of designs found: ", len(found_designs))
    print("LOG>>> Size of Best design found: ", len(best_designs))

