#!/bin/bash

response() {
  declare -r RESPONSE_CODE_DESCRIPTION_200=OK
  declare -r RESPONSE_CODE_DESCRIPTION_404='Not Found'

  RESPONSE_CODE=${1:-200}
  RESPONSE_CODE_DESCRIPTION=$(eval echo '${'RESPONSE_CODE_DESCRIPTION_${RESPONSE_CODE}'}')
  declare -r LAYOUT=${2:-${FUNCNAME[1]}}
  
  _BODY=$(mo ${APPROOT}/view/${LAYOUT}.mustache)
}
