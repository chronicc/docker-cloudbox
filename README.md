# Cloudbox

![test](https://github.com/chronicc/docker-cloudbox/actions/workflows/test.yml/badge.svg?branch=main)

> Container for working with pipelines and debugging cloud setups.

## Contents

### Basic Tools

The cloudbox contains a list of basic tools which have shown to be necessary in many scenarios.

* bash
* curl
* git
* jq
* make
* netstat
* nmap
* ping
* tar
* traceroute
* unzip
* wget
* yq
* zip

### Additional Packages

If you need more packages than what is included in this image, there are ways how you can add them during the container startup. Note that the more packages you add, the longer the startup time takes.

#### apk Packages

apk is the [Alpine package manager](https://wiki.alpinelinux.org/wiki/Alpine_Package_Keeper).

You can install additional packages via the `APK_PACKAGES` environment variable during startup. The variable takes a string of package names seperated by semicolon.

#### asdf Plugins

asdf is a third party [runtime version manager](https://asdf-vm.com/).

It enables you to install specific versions of tools in the form of plugins via the `ASDF_PLUGINS` environment variable. The variable takes a string with plugin tuples seperated by semicolon. The plugin tuple contains the name of the plugin and the version in the form of `plugin=version`. To get a list of all possible packages you can visit [the repository](https://github.com/asdf-vm/asdf-plugins/tree/master/plugins) or install asdf yourself and use the `asdf plugin list all` command.

#### Kubernetes Example for Additional Packages

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: example
spec:
  containers:
    - name: example
      image: chronicc/cloudbox
      env:
        - name: APK_PACKAGES
          value: "ansible,ansible-lint"
        - name: ASDF_PLUGINS
          value: "kubectl=latest,terraform=1.4.0"
```

### Sleep Mode

The image has a sleep mode integrated, which when activated allows the container to run endlessly until stopped from the outside. To use the sleep mode, you need to run the container with `sleep` as argument. This can be useful when debugging a pod from the inside.

#### Kubernetes Example for Sleep Mode

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: sleeper
spec:
  containers:
    - name: sleeper
      image: chronicc/cloudbox
      args:
        - sleep
```

## Development

This repository uses [mise](https://mise.jdx.dev/) for managing dependencies.

* To install dependencies, run `mise run pip:install`
* To build the image, run `mise run build`.
* To publish the image, run `mise run publish`.

## License

MIT
