exec 203> ${HOST_PATH}/${HASH}.lock &&
  if ${FLOCK} 203
  then
    
  else
  fi