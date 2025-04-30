ERROR=0 &&
  while read LINK
  do
    ${ECHO} &&
      export ARCHIVE=$( ${MKTEMP} --directory ) &&
      export RESOURCES=$( ${MKTEMP} --directory ) &&
      ${BASENAME} ${LINK} &&
      ${ECHO} tests ${OUT} &&
      DERIVATIVE=$( ${READLINK} ${LINK} ) &&
      if ! ${DERIVATIVE}/observe.wrapped.sh
      then
        ERROR=${LINK}
      fi
  done < <( ${FIND} ${OUT}/links -mindepth 1 -maxdepth 1 -type l | ${SORT} ) &&
  if [ ${ERROR} != 0 ]
  then
    ${ECHO} There was an error in ${ERROR} &&
      exit 62
  fi