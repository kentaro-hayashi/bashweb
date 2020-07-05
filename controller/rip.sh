#!/bin/bash

rip_show() {
  declare -r IFS_SAVE=$IFS
  declare -a LIST
  IFS=$'\n'
  declare COUNT=0
  for LINE in $(cat ${APPROOT}/db/rip); do
    LIST[$COUNT]=$LINE
    COUNT=$((COUNT+1))
  done
  IFS=${IFS_SAVE}
  response
}

rip_create() {
  echo "${REQUEST_name}" >> ${APPROOT}/db/rip
  declare -r NAME=${REQUEST_name}
  response
}
