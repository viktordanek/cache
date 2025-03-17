exec 203> ${HOST_PATH}/${HASH}.lock &&
  if ${FLOCK} 203
  then
    TEMPORARY_DIRECTORY=$( ${MKTEMP} --dry-run ${HOST_PATH}/XXXXXXXX ) &&
      ${MV} ${HOST_PATH}/${HASH} ${TEMPORARY_DIRECTORY} &&
      ${RM} ${HOST_PATH}/${HASH}.lock &&
      ${FLOCK} -u 203 &&
      ${FIND} ${HOST_PATH}/${HASH} -mindepth 1 -maxdepth 1 -type f -name "*.pid" | while read PID_FILE
      do
        ${TAIL} --pid $( ${CAT} ${PID_FILE} ) --follow /dev/null &&
          ${RM} ${PID_FILE}
      done &&
      ${FIND} ${HOST_PATH}/${HASH} -mindepth 1 -maxdepth 1 -type f -name "*.hash" | while read HASH_FILE
      do
        ${HOST_PATH}/$( ${CAT} ${HASH_FILE} )/evict.sh &&
          ${RM} ${HASH_FILE}
      done &&
      #
      ( ${POST} ${TEMPORARY_DIRECTORY} || ${TRUE} )
      #
      ${RM} --recursive --force ${TEMPORARY_DIRECTORY}
  else
  fi