if [ -z "${!TIMESTAMP_ENVIRONMENT_VARIABLE}" ]
then
  declare TIMESTAMP_ENVIRONMENT_VARIABLE=$( ${DATE} +%s )
    export ${TIMESTAMP_ENVIRONMENT_VARIABLE}
fi &&
  PARENT_HASH=${!HASH_ENVIRONMENT_VARIABLE} &&
  declare HASH_ENVIRONMENT_VARIABLE=$( ${ECHO} ${PRE_HASH} $(( ${!TIMESTAMP_ENVIRONMENT_VARIABLE} / ${LIFETIME } )) ) &&
  export ${HASH_ENVIRONMENT_VARIABLE} &&
  exec 201>${RESOURCES}/${!HASH_ENVIRONMENT_VARIABLE}.lock &&
  if ${FLOCK} 201
  then
    if [ ! -d ${RESOURCES}/${!HASH_ENVIRONMENT_VARIABLE} ]
    then
      ${MKDIR} ${RESOURCES}/${!HASH_ENVIRONMENT_VARIABLE}
    fi &&
      if [ ! -f ${RESOURCES}/${!HASH_ENVIRONMENT_VARIABLE}/${ORIGINATOR_PID}.pid ]
      then
        ${ECHO} ${ORIGINATOR_PID} > ${RESOURCES}/${HASH_ENVIRONMENT_VARIABLE}/${ORIGINATOR_PID}.pid
      fi &&
      if [ ! -l ${RESOURCES}/${!HASH_ENVIRONMENT_VARIABLE}/${PARENT_HASH}.hash ]
      then
        ${LN} --symbolic ${RESOURCES}/${PARENT_HASH}/teardown.sh ${RESOURCES}/${!HASH_ENVIRONMENT_VARIABLE}/${PARENT_HASH}.hash
      fi &&
      export RESOURCE=$( ${MKTEMP} --directory ${RESOURCES}/XXXXXXXX ) &&
      export RESOURCE_NAME=$( ${BASENAME} ${RESOURCE} ) &&
      export TARGET_MOUNT=${RESOURCE}/mount &&
      export TARGET=${TARGET_MOUNT}/target &&
      ${MKDIR} ${TARGET_MOUNT} &&
#
      if ${HAS_STANDARD_INPUT}
      then
        if ${ECHO} "${STANDARD_INPUT}" | ${INIT} ${@} > ${RESOURCE}/init.standard-output 2> ${RESOURCE}/init.standard-error
        then
          STATUS=${?}
        else
          STATUS=${?}
        fi
      else
        if ${INIT} ${@} > ${RESOURCE}/init.standard-output 2> ${RESOURCE}/init.standard-error
        then
          STATUS=${?}
        else
          STATUS=${?}
        fi
      fi &&
      ${ECHO} ${?} > ${RESOURCE}/init.status &&
#
      source ${MAKE_WRAPPER}/nix-support/setup-hook &&
#
      makeWrapper ${MAKE_WRAPPER_TEARDOWN} ${RESOURCE}/teardown.sh --set ORIGINATOR_PID ${ORIGINATOR_PID} --set RESOURCE_NAME ${RESOURCE_NAME} --set RESOURCES ${RESOURCES} --set STATUS 0 &&
#
      makeWrapper ${MAKE_WRAPPER_TEARDOWN} ${RESOURCE}/teardown.sh --set ORIGINATOR_PID ${ORIGINATOR_PID} --set RESOURCE_NAME ${RESOURCE_NAME} --set RESOURCES ${RESOURCES} --set STATUS ${STATUS} &&
#
#
      ( ${RESOURCE}/teardown.sh > /dev/null 2>&1 & ) && ## KLUDGE ALERT:  We should not have to redirect standard output and error.  this probably indicates an error. FIXME UNCOMMENT ME
#
#
      if [ ${STATUS} != 0 ]
      then
        exit ${INITIALIZATION_ERROR_CODE}
      elif [ $( ${FIND} ${TARGET_MOUNT} -mindepth 1 -maxdepth 1 | ${WC} --lines ) -gt 1 ]
      then
        exit ${OVER_INITIALIZED_TARGET_ERROR_CODE}
      elif [ ! -z "$( ${CAT} ${RESOURCE}/init.standard-error )" ]
      then
        exit ${STDERR_EMITTED_ERROR_CODE}
      else
        ${ECHO} ${TARGET}
      fi
#
      ${ECHO} ${TARGET}
#
  else
    exit ${LOCK_FAILURE}
  fi