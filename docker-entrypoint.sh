#!/usr/bin/env bash

export PATH="$HOME/.tfenv/bin:$PATH"

echo "INFO: Startup // Setting default kubectl version to ${KUBECTL_VERSION}"
ln -s "/usr/local/bin/kubectl-${KUBECTL_VERSION}" /usr/local/bin/kubectl

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
