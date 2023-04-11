#!/bin/bash
. /home/kc/.profile
. /etc/profile



##############################################################
# 1. Set Default Variables

HOST=$HOSTNAME

SHORT_DATE=`date '+%Y-%m-%d'`

TIME=`date '+%H%M'`


##############################################################
# Product Variables

PRODUCT_USERNAME=`whoami`

##############################################################
######### DO NOT MODIFY ABOVE THIS LINE ######################

# Setting up environment variables

filenametime1=$(date +"%m%d%Y%H%M%S")
filenametime2=$(date +"%Y-%m-%d %H:%M:%S")

export BASE_PATH="/home/weclouddata/linux"
export SCRIPTS_FOLDER="/home/kc/weclouddata/linux"
export ENV_ACTIVATION_LOCATION="/home/kc/weclouddata/linux/venv/bin/activate"

export LOGDIR='/home/kc/weclouddata/linux/logs'
export DOCDIR='/home/kc/weclouddata/linux/docs'

export TASK_CLIENT='client'
export TASK_TASK='product category api call'

export SCRIPT='script'
export LOG_FILE=${LOGDIR}/${SCRIPT}_${filenametime1}.log
export PYTHON_LOG_FILE=${LOGDIR}/${SCRIPT}_python_${filenametime1}.log


cd ${SCRIPTS_FOLDER}

# exec 2> ${LOG_FILE} 1>&2
exec > >(tee ${LOG_FILE})
exec 2> >(tee ${LOG_FILE} >&2)



##############################################################
# Begin PYTHON SCRIPT

# echo "[PROCESS]: STARTING RUN PYTHON SCRIPT '${SCRIPT}.py'.\n"
python3 ${SCRIPTS_FOLDER}/script.py

RC1=$?
if [ ${RC1} != 0 ]; then
	echo "\n[ERROR:] ERROR FOR SCRIPT ${SCRIPT}.py"
	echo "[ERROR:] RETURN CODE:  ${RC1}"
	echo "[ERROR:] REFER TO THE LOG FOR THE REASON FOR THE FAILURE."
	echo "[ERROR:] LOG FILE NAME: "${PYTHON_LOG_FILE}
	exit 1
fi

echo "\n[SUCESS]:SCRIPT ${SCRIPT}.py RUNNING SUCCEDED"
echo "[PROCESS]: END SCRIPT RUNNING PROCESS"

# ##ENDING PROCESS
# echo "\n[JOB]: LOAD SESSION OF ${TASK_CLIENT} ${TASK_TASK} PROCESS COMPLETED SUCCESSFULLY."
# echo "[JOB]: ${TASK_CLIENT} ${TASK_TASK} PROCESS END AT $(date)"
echo -e "\nEND"

exit 0

