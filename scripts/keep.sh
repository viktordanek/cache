HASH=${1} &&
  TARGET_PID=${2} &&
  ${MKDIR} ${HOST_PATH}/${HASH} &&
  ${LN}--symbolic ${ACTIVATION} ${HOST_PATH}/${HASH}/link &&
  ${ECHO} ${TARGET_PID} > ${HOST_PATH}/${HASH}/${TARGET_PID}.pid &&
  ${TOUCH} ${HOST_PATH}/${HASH}/flag &&
