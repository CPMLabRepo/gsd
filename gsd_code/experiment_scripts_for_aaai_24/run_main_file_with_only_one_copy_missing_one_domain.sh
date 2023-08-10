#/usr/bin/env bash
mkdir -p LOGS_main_file_with_only_one_copy/
pushd ../

# iterate over the domains
for domain in "Elevator" #"Gripper" "Satellite" "VisitAll"
do
  for prob in 1 #{1..5}
  do
    # if the following files are missing from ${domain}/ground_prob${prob}
    # human_problem.pddl
    # robot_problem.pddl
    # human_domain.pddl
    # robot_domain.pddl
    # then ground them
    if [[ ! -f ../domain/benchmarks/AAAI_23_Domains/${domain}/ground_prob${prob}/human_problem.pddl ]] && [[ ! -f ../domain/benchmarks/AAAI_23_Domains/${domain}/ground_prob${prob}/robot_problem.pddl ]] && [[ ! -f ../domain/benchmarks/AAAI_23_Domains/${domain}/ground_prob${prob}/human_domain.pddl ]] && [[ ! -f ../domain/benchmarks/AAAI_23_Domains/${domain}/ground_prob${prob}/robot_domain.pddl ]]
    then
      mkdir -p  ../domain/benchmarks/AAAI_23_Domains/${domain}/ground_prob${prob}/
      # remove the old files
      rm -f ../domain/benchmarks/AAAI_23_Domains/${domain}/ground_prob${prob}/human_problem.pddl ../domain/benchmarks/AAAI_23_Domains/${domain}/ground_prob${prob}/robot_problem.pddl ../domain/benchmarks/AAAI_23_Domains/${domain}/ground_prob${prob}/human_domain.pddl ../domain/benchmarks/AAAI_23_Domains/${domain}/ground_prob${prob}/robot_domain.pddl
      # ground the human and robot copies
      ./ground.sh ../domain/benchmarks/AAAI_23_Domains/${domain}/dom.pddl  ../domain/benchmarks/AAAI_23_Domains/${domain}/prob${prob}_copy.pddl ../domain/benchmarks/AAAI_23_Domains/${domain}/ground_prob${prob}/human_domain.pddl ../domain/benchmarks/AAAI_23_Domains/${domain}/ground_prob${prob}/human_problem.pddl
      ./ground.sh ../domain/benchmarks/AAAI_23_Domains/${domain}/dom.pddl  ../domain/benchmarks/AAAI_23_Domains/${domain}/prob${prob}.pddl ../domain/benchmarks/AAAI_23_Domains/${domain}/ground_prob${prob}/robot_domain.pddl ../domain/benchmarks/AAAI_23_Domains/${domain}/ground_prob${prob}/robot_problem.pddl

    fi
    gtimeout 30m python compiled_model.py -h_d ../domain/benchmarks/AAAI_23_Domains/${domain}/ground_prob${prob}/human_domain.pddl  -h_i  ../domain/benchmarks/AAAI_23_Domains/${domain}/ground_prob${prob}/human_problem.pddl -r_d ../domain/benchmarks/AAAI_23_Domains/${domain}/ground_prob${prob}/robot_domain.pddl  -r_i ../domain/benchmarks/AAAI_23_Domains/${domain}/ground_prob${prob}/robot_problem.pddl  -d_c 5 > ./experiment_scripts_for_aaai_24/LOGS_main_file_with_only_one_copy/${domain}_${prob}_5_main.txt
    gtimeout 30m python compiled_model_for_baseline_for_flattened.py -h_d ../domain/benchmarks/AAAI_23_Domains/${domain}/ground_prob${prob}/human_domain.pddl  -h_i  ../domain/benchmarks/AAAI_23_Domains/${domain}/ground_prob${prob}/human_problem.pddl -r_d ../domain/benchmarks/AAAI_23_Domains/${domain}/ground_prob${prob}/robot_domain.pddl  -r_i ../domain/benchmarks/AAAI_23_Domains/${domain}/ground_prob${prob}/robot_problem.pddl  -d_c 5 > ./experiment_scripts_for_aaai_24/LOGS_main_file_with_only_one_copy/${domain}_${prob}_5_baseline_flattened.txt
    gtimeout 30m python compiled_model_for_baseline_just_exhaustive_search.py -h_d ../domain/benchmarks/AAAI_23_Domains/${domain}/ground_prob${prob}/human_domain.pddl  -h_i  ../domain/benchmarks/AAAI_23_Domains/${domain}/ground_prob${prob}/human_problem.pddl -r_d ../domain/benchmarks/AAAI_23_Domains/${domain}/ground_prob${prob}/robot_domain.pddl  -r_i ../domain/benchmarks/AAAI_23_Domains/${domain}/ground_prob${prob}/robot_problem.pddl  -d_c 5> ./experiment_scripts_for_aaai_24/LOGS_main_file_with_only_one_copy/${domain}_${prob}_5_baseline_exhaustive_search.txt
  done
done
popd
