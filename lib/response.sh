#!/bin/bash

response() {
  RESPONSE_CODE=${1:-200}
  add_response_code_description
  declare -r LAYOUT=${2:-${FUNCNAME[1]}}
  
  RESPONSE_BODY=$(mo ${APPROOT}/view/${LAYOUT}.mustache)
  CONTENT_TYPE="text/html"
}

add_response_code_description() {
  declare -r RESPONSE_CODE_DESCRIPTION_200=OK
  declare -r RESPONSE_CODE_DESCRIPTION_404='Not Found'
  RESPONSE_CODE_DESCRIPTION=$(eval echo '${'RESPONSE_CODE_DESCRIPTION_${RESPONSE_CODE}'}')
}