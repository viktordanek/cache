TIMESTAMP=${TIMESTAMP:$(${DATE} +%s )} &&
  HASH=$( ${ECHO} ${PRE_HASH} $(( ${TIMESTAMP} / ${LIFESPAN} )) | ${SHA512SUM} | ${CUT} --bytes -128 ) &&
  exec 201>${RESOURCES}/${HASH}.lock &&
  if ${FLOCK} 201
  then
    if [ -d ${RESOURCES}/${HASH} ]
    then
    else
    fi
  fi