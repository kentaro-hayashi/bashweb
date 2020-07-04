#!/bin/bash

route() {
  declare -r METHOD=$(echo $1 | tr '[a-z]' '[A-Z]')
  declare -r REQUEST_PATH=$(echo ${2//_/__} | sed 's/\//_s/g' | sed 's/\./_d/g')
  eval _ROUTER_${METHOD}_${REQUEST_PATH}=$3
}

call_controller() {
  declare -r METHOD=$(echo $1 | tr '[a-z]' '[A-Z]')
  declare -r REQUEST_PATH=$(echo ${2//_/__} | sed 's/\//_s/g' | sed 's/\./_d/g')
  eval '${'_ROUTER_${METHOD}_${REQUEST_PATH}'}'
  [ "${RESPONSE_CODE+foo}" ] || response 404 404
}
