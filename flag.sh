if ${TOUCH} /resource > /dev/null 2>&1
then
  ${ECHO} did touch /resource
fi &&
  ${FIND} /resource -type f | ${SORT} | while read FILE
  do
    ${ECHO} ${FILE} &&
      if [ ${FILE} != /resource/${NAME}.standard-output ] && [ ${FILE} != /resource/${NAME}.standard-error ] && [ ${FILE} != /resource/teardown.sh ]
      then
        ${CAT} ${FILE}
      fi &&
      ${ECHO}
  done