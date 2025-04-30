${MKDIR} /mount/target &&
  ${ECHO} ${UUID} > /mount/target/uuid
  if [ "${1}" == "fd4107d952c0d02f4ea2e8963d673543791619d2ff0178d03222ea551c539c235a516d9f6dbb2c852618c634ead3ebc72d6beff6ee08880d422e10341390a94c" ]
  then
    exit 19
  fi