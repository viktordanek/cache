exec 201> /mount/${RESOURCE_NAME}.lock &&
  if ${FLOCK} 201
  then
   if [ ${STATUS} == 0 ]
    then
      TIMEOUT=$(( ${LIFESPAN} - ( $( ${DATE} +%s ) % ${LIFESPAN} ) )) &&
        ( ${INOTIFYWAIT} --event delete /mount/${RESOURCE_NAME}/TEARDOWN_START_FLAG --timeout ${TIMEOUT} --quiet || ${TRUE} ) &&
        ${TAIL} --follow /dev/null --pid ${ORIGINATOR_PID}
    fi &&
    export RESOURCE=/mount/${RESOURCE_NAME} &&



























# 8
    if ${RELEASE} > /mount/${RESOURCE_NAME}/release.standard-output 2> /mount/${RESOURCE_NAME}/release.standard-error
    then
      ${ECHO} ${?} > /mount/${RESOURCE_NAME}/release.status
    else
      ${ECHO} ${?} > /mount/${RESOURCE_NAME}/release.status
    fi &&
#
#
       ( ${POST} || ${TRUE} ) &&
#
      ${RM} --recursive --force /mount/${RESOURCE_NAME}.lock /mount/${RESOURCE_NAME}
  else
    ${ECHO} FAILED TO LOCK /mount/${RESOURCE_NAME}.lock >&2 &&
      exit ${LOCK_FAILURE}
  fi