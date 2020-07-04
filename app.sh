#!/bin/bash
declare -r APPROOT=$(cd $(dirname $BASH_SOURCE); pwd)
source ${APPROOT}/config.sh
source ${APPROOT}/lib/index.sh
source ${APPROOT}/vendor/mo/mo

# load controllers
for SCRIPT in $(find ${APPROOT}/controller -name "*.sh"); do
    source $SCRIPT
done

source ${APPROOT}/route.sh

read INPUT
INPUT=`echo ${INPUT} | tr -d "\r"`
HTTP_METHOD=`echo ${INPUT} | cut -f 1 -d " " | tr '[a-z]' '[A-Z]'`
REQUEST_PATH=`echo ${INPUT} | cut -f 2 -d " "`

log info $INPUT
while :
do
  if [ -z "$INPUT" ]; then
    break
  fi
  read INPUT
  INPUT=`echo ${INPUT} | tr -d "\r"`
  log info $INPUT
done
log info breaked

call_controller ${HTTP_METHOD} ${REQUEST_PATH}
echo "HTTP/1.0 ${RESPONSE_CODE} ${RESPONSE_CODE_DESCRIPTION}"
echo
echo ${_BODY}
echo 
