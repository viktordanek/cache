source ${MAKE_WRAPPER}/nix-support/setup-hook
  HASH=$( ${ECHO} ${PREHASH} $(( ${TIMESTAMP} / ${DURATION} )) | ${SHA512SUM} | ${CUT} --bytes -128 ) &&
  exec 201> ${HOST_PATH}/${HASH}.lock &&
  if ${FLOCK} 201
  then
    if [ -d ${HOST_PATH}/${HASH} ]
    then
      ${ECHO} ${TARGET_PID} > ${HOST_PATH}/${HASH}/${TARGET_PID}.pid
    else
      ${MKDIR} ${HOST_PATH}/${HASH} &&
        ${TOUCH} ${HOST_PATH}/${HASH}/keep.flag &&
        makeWrapper ${MAKE_WRAPPER_EVICT} ${HOST_PATH}/${HASH}/evict.sh &&
        ${TOUCH} ${HOST_PATH}/${HASH}/evict.flag &&
        INTERVAL_START=$(( ${TIMESTAMP} / ${DURATION} * ${DURATION} )) &&
        NEXT_CHANGE=$(( ${INTERVAL_START} + ${DURATION} )) &&
        REMAINING_TIME=$(( ${NEXT_CHANGE} - ${TIMESTAMP} )) &&
        ${KEEP} ${HASH} ${TARGET_PID} ${REMAINING_TIME} &&
        ${INOTIFY_WAIT} -e delete_self ${HOST_PATH}/${HASH}/keep.flag -q
    fi &&
    ${READLINK} ${HOST_PATH}/${HASH}/link
  else
    ${ECHO} ${HASH} >&2 &&
      exit ${FLOCK_ERROR}
  fi