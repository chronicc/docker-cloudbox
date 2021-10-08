#!/usr/bin/env bash

echo "INFO: Setting default kubectl version to ${KUBECTL_VERSION}"
cd /usr/local/bin && ln -s "kubectl-${KUBECTL_VERSION}" kubectl

case $1 in
    sleep )
        echo "INFO: Startup // Running sleeping loop"
        trap "exit" SIGHUP
        trap "exit" SIGINT
        trap "exit" SIGTERM
        while true; do
            sleep 1
        done
        ;;
    * )
        echo "INFO: Startup // Command Execution '${*}'"
        exec "$@"
        ;;
esac
