#!/bin/bash

declare -r LOGLEVEL_DEBUG_DEBUG=true
declare -r LOGLEVEL_DEBUG_INFO=true
declare -r LOGLEVEL_DEBUG_WARN=true
declare -r LOGLEVEL_DEBUG_ERROR=true
declare -r LOGLEVEL_INFO_DEBUG=false
declare -r LOGLEVEL_INFO_INFO=true
declare -r LOGLEVEL_INFO_WARN=true
declare -r LOGLEVEL_INFO_ERROR=true
declare -r LOGLEVEL_WARN_DEBUG=false
declare -r LOGLEVEL_WARN_INFO=false
declare -r LOGLEVEL_WARN_WARN=true
declare -r LOGLEVEL_WARN_ERROR=true
declare -r LOGLEVEL_ERROR_DEBUG=false
declare -r LOGLEVEL_ERROR_INFO=false
declare -r LOGLEVEL_ERROR_WARN=false
declare -r LOGLEVEL_ERROR_ERROR=true

declare -r LOGFILE=${APPROOT}/log/log.txt

log() {
  declare -r TYPE=`echo $1 | tr '[a-z]' '[A-Z]'`
  declare -r SHOW=$(eval echo '${'LOGLEVEL_${LOGLEVEL}_${TYPE}'}')
  if "${SHOW}"; then
    declare -r OUTTEXT=`echo $@ | sed "s/^$1/\[${TYPE}\] /"`
    echo $(date -u "+%Y/%m/%dT%H:%M:%SZ") SESSION:${SESSION_ID} ${OUTTEXT} >> ${LOGFILE}
  fi
}
