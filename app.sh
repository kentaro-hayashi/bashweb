#!/bin/bash
declare -r SESSION_ID=$RANDOM
declare -r APPROOT=$(cd $(dirname $BASH_SOURCE); pwd)
source ${APPROOT}/config.sh
source ${APPROOT}/lib/index.sh
source ${APPROOT}/vendor/mo/mo

# load controllers
for SCRIPT in $(find ${APPROOT}/controller -name "*.sh"); do
  source $SCRIPT
done

source ${APPROOT}/route.sh

# parse HTTP request
declare INPUT
read INPUT
INPUT=`echo ${INPUT} | tr -d "\r"`
declare HTTP_METHOD=`echo ${INPUT} | cut -f 1 -d " " | tr '[a-z]' '[A-Z]'`
declare REQUEST_PATH=`echo ${INPUT} | cut -f 2 -d " "`

log debug $INPUT
while :
do
  read INPUT
  INPUT=`echo ${INPUT} | tr -d "\r"`
  if [ -z "$INPUT" ]; then
    break
  fi
  declare HEADER_KEY=$(echo ${INPUT} | cut -f 1 -d ":" | tr '[A-Z]' '[a-z]')
  declare HEADER_VALUE=$(echo ${INPUT} | cut -f 2 -d ":" | sed 's/^ *//' )
  if [ "${HEADER_KEY}" = "content-type" ]; then
    declare -r REQUEST_CONTENT_TYPE=${HEADER_VALUE}
  fi
  if [ "${HEADER_KEY}" = "content-length" ]; then
    declare -r REQUEST_CONTENT_LENGTH=${HEADER_VALUE}
  fi
  log debug $INPUT
done

if [ "${HTTP_METHOD}" = "POST" -o "${HTTP_METHOD}" = "PUT" ]; then
  if [ "${REQUEST_CONTENT_TYPE}" = "application/x-www-form-urlencoded" ]; then
    read -n ${REQUEST_CONTENT_LENGTH} INPUT
    eval REQUEST_${INPUT//&/;REQUEST_}
  else
    log error "Not implemented: ${HTTP_METHOD}, ${REQUEST_CONTENT_TYPE}"
  fi
fi

log info "Request received: ${HTTP_METHOD} ${REQUEST_PATH}"

# routing
if [ "${HTTP_METHOD}" = "GET" ]; then
  static_file_loader ${REQUEST_PATH}
fi
if [ -z "${RESPONSE_CODE}" ]; then
  call_controller ${HTTP_METHOD} ${REQUEST_PATH}
fi

# send response
echo "HTTP/1.0 ${RESPONSE_CODE} ${RESPONSE_CODE_DESCRIPTION}"
echo "Content-Type: ${CONTENT_TYPE}"
echo
if [ -n "$RESPONSE_FILE" ]; then
  cat $RESPONSE_FILE
else
  echo -n ${RESPONSE_BODY}
fi
log info "Responsed ${RESPONSE_CODE} ${RESPONSE_CODE_DESCRIPTION}"
