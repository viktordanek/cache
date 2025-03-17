HASH=$( ${ECHO} ${PREHASH} $(( ${TIMESTAMP} / ${DURATION} )) | ${SHA512SUM} | ${CUT} --bytes -128 ) &&
  exec 201> ${HOST_PATH}/${HASH}.lock &&
  if ${FLOCK} 201
  then
    if [ -d ${HOST_PATH}/${HASH} ]
    then
      ${ECHO} ${TARGET_PID} > ${HOST_PATH}/${HASH}/${TARGET_PID}.pid
    else
      ${KEEP} ${HASH} ${TARGET_PID} &&
        ${INOTIFY_WAIT} ${HOST_PATH}/${HASH}/flag
    fi &&
    ${READLINK} ${HOST_PATH}/${HASH}/link
  else
    ${ECHO} ${HASH} >&2 &&
      exit ${FLOCK_ERROR}
  fi