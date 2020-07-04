#!/bin/bash

log() {
  declare -r LOGFILE=${APPROOT}/log/log.txt
  declare -r TYPE=`echo $1 | tr '[a-z]' '[A-Z]'`
  declare -r OUTTEXT=`echo $@ | sed "s/^$1/\[${TYPE}\] /"`
  echo ${OUTTEXT} >> ${LOGFILE}
}
