#!/usr/bin/env python3.8

'''
Topic   :: Search methods
Project :: Explanations for Multi-Model Planning
Author  :: Tathagata Chakraborti
Date    :: 09/29/2016
'''

from queue import PriorityQueue, Queue
import matplotlib.pyplot as plt 
import networkx as nx
import copy

'''
Method :: Exhaustive Search
'''

def KelseyExhaustiveSearch(problem):

    startState = problem.getStartState() #LIST; gets original root node, list of state features
    
    #might need to put this in some sort of loop to assure nodes are added to it
    graph = nx.Graph() 
    closed = set()  
    numberOfNodesExpanded = 0  
    node_num = 1
    #nx.draw_networkx(graph, labels={n: str(n) for n in graph.nodes()}, **options)

    graph.add_nodes_from([(1, {"startState": startState}),])
    options = {
                "font_size": 36,
                "node_size": 3000,
                "node_color": "blue",
                "edgecolors": "black",
                "linewidths": 5,
                "width": 5,
            } 
    
    node_list = [ [startState, [] ] ] #state, list of changes it took to get to that state
    print("Runnning Kelsey's Exhaustive Search...")

    #while there is a node or set of nodes to iterate over
    #wil keep looping
    #while node_list:

    node = node_list[0] #gets initial state of current node 
    goal_check, old_state = problem.isGoal(node[0])
    if frozenset(node[0]) not in closed: #if node has not been explored yet; node[0] equal to startState
        closed.add(frozenset(node[0])) #add node to closed set so in future we know it was explored

            #remove modifications from startState (initial state); gives list of modifications and new state
            #technically multiple changes = new node here; whereas it should be one change = new node, no matter how many of them 
            # new_initial_state = []
            # new_child_states_list = []
            # for modification in mod_list[1:]:
            #     new_initial_state = node[0].copy()
            #     for element in modification: 
            #         print(element)
            #         if element in new_initial_state:
            #             print(element," is getting removed")
            #             new_initial_state.remove(element)
            #         else:
            #             print(element," is not in the model")
            #     new_child_states_list.append(new_initial_state)
            # print("new child states list", new_child_states_list)

        goal_check, old_state = problem.isGoal(node[0]) #I DONT WANT A PLAN, I WANT A STATE



            #successor_list = problem.getSuccessors(node, old_state) #get successors of node; node original state; old_state is state before changes (was initial state, plan)
            #print("successor list", successor_list)
        numberOfNodesExpanded += 1 #increase count of nodes that have been expanded, since current one is being expanded

            #get min/max
            #apply change, generate new nodes, add these to list
            #add these to node_list one by one 
            #individually review node by getting min/max and generating successors 


    #nx.draw_networkx(graph, labels={node_num: str(node_num) for n in graph.nodes()}, **options) #move to after all nodes explored 
    #plt.show()

    return None
 

    #         successor_list         = problem.getSuccessors(node, old_plan) 

    #         numberOfNodesExpanded += 1  

    #         if not numberOfNodesExpanded % 100:
    #             print("Number of Nodes Expanded =", numberOfNodesExpanded)
            
    #         while successor_list: 
                
    #             candidate_node     = successor_list.pop() 

    #             new_node           = [candidate_node[0], node[1] + [candidate_node[1]]]  
                
    #             fringe.put((problem.heuristic(candidate_node[0]) + len(new_node[1]), new_node)) 

'''
Method :: Astar Search
'''

def astarSearch(problem):

    startState            = problem.getStartState() #gets problem start state 
    fringe                = PriorityQueue()  #gets sum of heuristic value and cost to reach each node from start; then prioritizes nodes for search 
    closed                = set() #keeps track of explored nodes 
    numberOfNodesExpanded = 0 #tracks how many nodes have been expanded 

    fringe.put((problem.heuristic(startState), [startState, []])) #adds start state to queue with heuristic priority value & list of nodes and their plans

    print("Runnning aStar Search...")
    while not fringe.empty(): #while our priority queue is not empty, do the following

        priority, element = fringe.get() #get highest priority node; priority is heurisitc value, element is list of startState elements
        
        node = fringe.get()[1] #get highest priority node 
        goal_check, old_plan = problem.isGoal(node[0]) #check whether we're in a goal state or not; old_plan is a list b/c get_plan returns [plan and cost]
        if goal_check:
            print("Goal Found! Number of Nodes Expanded =", numberOfNodesExpanded, node[1])
            return node[1]

        if frozenset(node[0]) not in closed: #node[0] is the startState assigned above and is a list of featueres (Ex: unstack-has-precondition-on ?x ?y, has-initial-state-ontable d)

            closed.add(frozenset(node[0])) #add node to closed set so in future we know it was explored

            successor_list         = problem.getSuccessors(node, old_plan) #get successors of node
            #print("successor list", successor_list)

            numberOfNodesExpanded += 1 #increase count of nodes that have been expanded, since current one is being expanded

            if not numberOfNodesExpanded % 100:
                print("Number of Nodes Expanded =", numberOfNodesExpanded)
            
            while successor_list: #look at successor nodes that were generated
                
                candidate_node     = successor_list.pop() #get next successor in list

                 #create a new node using the successor's state/plan (you want state change to get to node)
                new_node           = [candidate_node[0], node[1] + [candidate_node[1]]] #new node, list of actions original + new action that it took to reach that node
                
                fringe.put((problem.heuristic(candidate_node[0]) + len(new_node[1]), new_node)) #add node to fringe list to be explored,

                #Keep looping until all successor nodes are explored ; either return a goal state or say there isn't one 

    return None

def BFSearch(problem):

    startState            = problem.getStartState()
    fringe                = Queue()
    closed                = set()
    numberOfNodesExpanded = 0
    conflict_list = []
    current_sol = []

    fringe.put((problem.heuristic(startState), [startState, []]))

    print("Runnning BFS...")
    while not fringe.empty():
        node = fringe.get()[1]
        goal_check, old_plan = problem.isGoal(node[0])
        if not goal_check:
            #print "Goal not Found! Number of Nodes Expanded =", numberOfNodesExpanded
            #print "Failed for path",node[1]
            conflict_list.append(set(node[1]))
        else:
            #print "It was fine"
            if frozenset(node[0]) not in closed:
                conflict_flag = False
                for item in conflict_list:
                    if item <= set(node[1]) and len(item) > 0:
                        conflict_flag = True
                if not conflict_flag:
                    current_sol = node[1]
                    closed.add(frozenset(node[0]))

                    successor_list         = problem.getSuccessors(node, old_plan)
                    numberOfNodesExpanded += 1
                    #print successor_list, node[1]
                    if not numberOfNodesExpanded % 100:
                        print("Number of Nodes Expanded =", numberOfNodesExpanded)

                    while successor_list:

                        candidate_node     = successor_list.pop()
                        new_node           = [candidate_node[0], node[1] + [candidate_node[1]]]

                        fringe.put((problem.heuristic(candidate_node[0]) + len(new_node[1]), new_node))
    #print "curr", current_sol
    return current_sol
