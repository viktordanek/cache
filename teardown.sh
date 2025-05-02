TIMEOUT=$(( ${LIFESPAN} - ( $( ${DATE} +%s ) % ${LIFESPAN} ) )) && ${ECHO} NOW=$( ${DATE} +%s ) LIFESPAN=${LIFESPAN} TIMEOUT=${TIMEOUT} > /mount/${RESOURCE_NAME}/timeout &&
  ( ${INOTIFYWAIT} --event delete /mount/${RESOURCE_NAME}/TEARDOWN_START_FLAG --timeout ${TIMEOUT} --quiet || ${TRUE} ) &&
  if [ -f /mount/${RESOURCE_NAME/TEARDOWN_FORCE_FLAG} ]
  then
    ${FIND} /mount/${RESOURCE_NAME} -mindepth 1 -maxdepth 1 -type f -name "*.pid" | while read PID_FILE
    do
      PID=$( ${CAT} ${PID_FILE} ) &&
        ${KILL} ${PID}
    done
  fi &&
  ${FIND} /mount/${RESOURCE_NAME} -mindepth 1 -maxdepth 1 -type l -name "*.hash" | while read HASH_LINK
  do
    DIRECTORY=$( ${READLINK} ${HASH_LINK} ) &&
    exec 202> ${DIRECTORY}.lock &&
    if ${FLOCK} 202
    then
      if [ -d ${DIRECTORY} ]
      then
        if [ -f ${DIRECTORY}/TEARDOWN_START_FLAG ]
        then
          ${RM} ${DIRECTORY}/TEARDOWN_START_FLAG &&
            ${FLOCK} -u 202 &&
            ${INOTIFYWAIT} --event delete ${DIRECTORY} --quiet &&
            ${RM} ${HASH_LINK}
        else
          ${FLOCK} -u 202
            ${INOTIFYWAIT} --event delete ${DIRECTORY} --quiet &&
            ${RM} ${HASH_LINK}
        fi
      else
        ${RM} ${HASH_LINK}
      fi
    else
      exit ${LOCK_FAILURE}
    fi
  done &&
  if [ -f /mount/${RESOURCE_NAME}/TEARDOWN_FORCE_FLAG ]
  then
    ${FIND} /mount/${RESOURCE_NAME} -mindepth 1 -maxdepth 1 -type f -name "*.pid" | while read PID_FILE
    do
      PID=$( ${CAT} ${PID_FILE} ) &&
        while ${KILL} ${PID}
        do
          ${SLEEP}
        done &&
        ${RM} ${PID_FILE}
    done
  fi &&
  ${FIND} /mount/${RESOURCE_NAME} -mindepth 1 -maxdepth 1 -type f -name "*.pid" | while read PID_FILE
  do
    PID=$( ${CAT} ${PID_FILE} ) &&
      ${TAIL} --follow /dev/null --pid ${PID} &&
      ${RM} ${PID_FILE}
  done &&
  exec 201> /mount/${RESOURCE_NAME}.lock &&
  if ${FLOCK} 201
  then
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