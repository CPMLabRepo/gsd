# path to fast downward #
# VAL_PATH=$(locate VAL/validate|head -n 1)
VAL_PATH="/usr/local/bin/validate"



# Check if VAL_PATH is empty or not found
if [ -z "${VAL_PATH}" ]; then
    echo "VAL tool 'validate' not found or not installed. Make sure you have installed VAL correctly."
    exit 1
fi

# Check if three arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <domain_file> <problem_file> <plan_file>"
    exit 1
fi

# Display the input file paths
DOMAIN_FILE="$1"
PROBLEM_FILE="$2"
PLAN_FILE="$3"
#echo "Domain file: ${DOMAIN_FILE}"
#echo "Problem file: ${PROBLEM_FILE}"
#echo "Plan file: ${PLAN_FILE}"



# validate plan given domain and problem
output=$(${VAL_PATH} $1 $2 $3 | grep "Successful plans:"|wc -l)

if [ ${output} -gt 0 ]; then
    echo "True"
else
    echo "False"
fi
