#!/bin/bash

trap exit INT;
SCRIPTDIR=$(cd $(dirname $BASH_SOURCE); pwd)
TCPSERVER=${SCRIPTDIR}/vendor/tcpserver/ucspi-tcp-0.88/tcpserver

case $1 in

############################
## Install Dependencies
############################
  install)
    echo "Install dependencies..."
    mkdir -p ${SCRIPTDIR}/vendor/mo
    pushd ${SCRIPTDIR}/vendor/mo
    if [ ! -e "./mo" ]; then
      wget https://raw.githubusercontent.com/tests-always-included/mo/master/mo
    fi
    popd
    mkdir -p ${SCRIPTDIR}/vendor/tcpserver
    pushd ${SCRIPTDIR}/vendor/tcpserver
    if [ ! -e "${TCPSERVER}" ]; then
      wget http://cr.yp.to/ucspi-tcp/ucspi-tcp-0.88.tar.gz
      tar zxvf ucspi-tcp-0.88.tar.gz
      pushd ucspi-tcp-0.88
      make
      popd
    fi
    popd
    mkdir -p ${SCRIPTDIR}/log
    mkdir -p ${SCRIPTDIR}/db
    echo "Install finished!"
    ;;

############################
## Start Server
############################
  start)
    cat <<EOF
🐠 bashweb server 🐠

press ctrl+c to quit
listening 8080 port...
EOF

    while :
    do
      ${TCPSERVER} 0.0.0.0 8080 /bin/bash ${SCRIPTDIR}/app.sh
    done
    ;;

############################
## HELP
############################
  *)
    cat <<EOF
🐠 bashweb server usage 🐠
install dependencies:
  $ ./bashweb.sh install
start server:
  $ ./bashweb.sh start
EOF
    ;;
esac
