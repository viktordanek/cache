HASH=${1} &&
  TARGET_PID=${2} &&
  REMAINING_TIME=${3} &&
  if ${LN}--symbolic $( ${ACTIVATION} 2> ${HOST_PATH}/${HASH}/activation.standard-error ) ${HOST_PATH}/${HASH}/link
  then
    STATUS=${?}
  else
    STATUS=${?}
  fi &&
  ${ECHO} ${STATUS} > ${HOST_PATH}/${HASH}/activation.status &&
  if [ ${STATUS} == 0 ]
  then
    ${ECHO} ${TARGET_PID} > ${HOST_PATH}/${HASH}/${TARGET_PID}.pid 2> ${HASH_PATH}
  fi &&
  ${RM} ${HOST_PATH}/${HASH}/keep.flag &&
  ${INOTIFY_WAIT} -e delete_self ${HOST_PATH}/${HASH}/evict.flag -q -t ${REMAINING_TIME} &&
  if [ -f ${HOST_PATH}/${HASH}/evict.sh ]
  then
    ${HOST_PATH}/${HASH}/evict.sh
  fi
