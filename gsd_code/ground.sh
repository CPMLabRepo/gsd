#/usr/bin/env bash

# path to pr2plan #
#PR2PLAN_PATH=$(locate pr2plan | head -n 1)

# ground domain and problem input using pr2plan #
rm -f *-domain.pddl *-problem.pddl obs.dat
i#touch obs.dat
#$PR2PLAN_PATH -d $1 -i $2 -o ./obs.dat > stdout.txt
python3 ./grounder/grounder_interface.py $1  $2 ./pr-domain.pddl ./pr-problem.pddl
# post-process grounded domain and problem files #
cat pr-domain.pddl | grep -vE "(EXPLAIN|increase|functions)" > tr-domain.pddl
cat pr-problem.pddl | grep -vE "(EXPLAIN|increase|metric)" > tr-problem.pddl

#sed -i 's/_R//g' tr-domain.pddl
#sed -i 's/_R//g' tr-problem.pddl

#Kelsey Added
#sed -i 's/r-domain.pddl/tr-domain.pddl/g' tr-domain.pddl
#sed -i 's/r-problem.pddl/tr-problem.pddl/g' tr-problem.pddl

#./fdplan.sh tr-domain.pddl tr-problem.pddl
mv tr-domain.pddl $3
mv tr-problem.pddl $4
rm -f *-domain.pddl *-problem.pddl obs.dat
