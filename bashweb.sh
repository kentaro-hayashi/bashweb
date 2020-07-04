#!/bin/bash

trap exit INT;
SCRIPTDIR=$(cd $(dirname $BASH_SOURCE); pwd)

case $1 in

  install)
    echo "Install dependencies..."
    mkdir -p ${SCRIPTDIR}/vendor/mo
    pushd ${SCRIPTDIR}/vendor/mo
    wget https://raw.githubusercontent.com/tests-always-included/mo/master/mo
    popd
    ;;

  start)
    cat <<EOF
🐠 bashweb server 🐠

press ctrl+c to quit
listening 8080 port...
EOF

    while :
    do
      netcat -lp 8080 -e "/bin/bash ${SCRIPTDIR}/app.sh"
    done
    ;;

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
