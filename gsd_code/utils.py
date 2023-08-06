'''
Method :: compute plan from domain and problem files
'''
import os, re

__FD_PLAN_CMD__ = "./fdplan.sh {} {}"
__FD_PLAN_COST_CMD__ = "./get_plan_cost.sh"

def get_plan(domainFileName, problemFileName):
    output = os.popen(__FD_PLAN_CMD__.format(domainFileName, problemFileName)).read().strip()
    #print("get plan output", output)
    plan   = [item.strip() for item in output.split('\n')] if output != '' else []
    if len(plan) > 0:
        output = os.popen(__FD_PLAN_COST_CMD__).read().strip()
        cost   = int(output)
    else:
        cost = 0

    return [plan, cost]

