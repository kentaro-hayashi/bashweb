#!/bin/bash

declare -r MIME_TYPE_JPG="image/jpeg"
declare -r MIME_TYPE_PNG="image/png"
declare -r MIME_TYPE_ICO="image/x-icon"
declare -r MIME_TYPE_TXT="text/plain"
declare -r MIME_TYPE_HTML="text/html"

create_static_index() {
  declare -r ESCAPED_APPROOT=$(echo ${APPROOT//_/__} | sed 's/\//_s/g')
  for STATIC_FILE in $(find ${APPROOT}/static -type f); do
    declare ESCAPED_FILE_NAME=$(echo ${STATIC_FILE//_/__} | sed 's/\//_s/g' | sed 's/\./_d/g')
    declare KEY=$(echo ${ESCAPED_FILE_NAME} | sed "s/^${ESCAPED_APPROOT}_sstatic//")
    eval ${KEY}=${STATIC_FILE}
  done
}
create_static_index

static_file_loader() {
  declare -r KEY=$(echo ${1//_/__} | sed 's/\//_s/g' | sed 's/\./_d/g')
  if [ -n "$(eval echo '${'${KEY}'}')" ];then
    RESPONSE_BODY=$(eval cat '${'${KEY}'}')
    declare -r EXT=$(echo ${KEY##*_d} | tr '[a-z]' '[A-Z]')
    CONTENT_TYPE=$(eval echo '${'MIME_TYPE_${EXT}'}')
    RESPONSE_CODE=200
    add_response_code_description
  fi
}
