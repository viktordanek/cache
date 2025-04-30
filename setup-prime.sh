export RESOURCE=$( ${MKTEMP} --directory ${RESOURCES}/XXXXXXXX ) &&
  export RESOURCE_NAME=$( ${BASENAME} ${RESOURCE} ) &&
  export TARGET_MOUNT=${RESOURCE}/mount &&
  export TARGET=${TARGET_MOUNT}/target &&
  ${ECHO} ${TARGET}