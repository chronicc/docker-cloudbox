#!/usr/bin/env bash

. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"


# apk Packages
IFS=',' read -ra packages <<< "$APK_PACKAGES"
for package in "${packages[@]}"; do
    echo "INFO: Startup // Installing apt package '${package}'."
    apk add $package
done


# asdf Plugins
IFS=',' read -ra plugins <<< "$ASDF_PLUGINS"
for plugin in "${plugins[@]}"; do
    plugin_name="${plugin%=*}"
    plugin_version="${plugin#*=}"
    echo "INFO: Startup // Installing asdf plugin '${plugin_name}' with version '${plugin_version}'."
    asdf plugin add $plugin_name
    asdf install $plugin_name $plugin_version
    asdf global $plugin_name $plugin_version
done


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
