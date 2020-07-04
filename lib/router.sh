#!/bin/bash

route() {
  declare -r METHOD=$(echo $1 | tr '[a-z]' '[A-Z]')
  declare -r REQUEST_PATH=$(echo $2 | sed 's/_/__/g' | tr '/' '_')
  eval _ROUTER_${METHOD}_${REQUEST_PATH}=$3
}

call_controller() {
  declare -r METHOD=$(echo $1 | tr '[a-z]' '[A-Z]')
  declare -r REQUEST_PATH=$(echo $2 | sed 's/_/__/g' | tr '/' '_')
  eval '${'_ROUTER_${METHOD}_${REQUEST_PATH}'}'
  [ "${RESPONSE_CODE+foo}" ] || response 404 404
}
