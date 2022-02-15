# Cloudbox

> All-in-one debugging container for working with cloud setups.

## Contents

### Tools

The cloudbox contains a list of reasonable tools necessary for working with the cloud.

* [awscli](https://aws.amazon.com/cli/) - command line tool for AWS
* [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) - command line tool for Kubernetes
* [jq](https://stedolan.github.io/jq/) - command line processor for json
* [yq](https://github.com/mikefarah/yq) - command line processor for yaml

As well as common linux tools for setup and debugging.

* bash
* curl
* nmap
* netstat
* ping
* tar
* traceroute
* unzip
* wget

### kubectl Version (version 0.2.0)

On default, the latest available kubectl version is used when running `kubectl`. For compatibility the latest patch level of all minor versions are installed in the image and can be used by appending the major and minor version to the binary (e.g. `kubectl-1.19`). It's also possible to configure the default kubectl version by setting the `KUBECTL_VERSION` environment variable (which also only takes the major and minor version).

Currently available versions are

* `KUBECTL_VERSION=1.20`
* `KUBECTL_VERSION=1.21`
* `KUBECTL_VERSION=1.22` (default)
* `KUBECTL_VERSION=1.23`

#### Kubernetes Example for kubectl version

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: node_list
spec:
  containers:
  - name: node_list
    image: chronicc/cloudbox:0.2.0
    args:
    - /bin/bash
    - -c
    - "kubectl get nodes"
    env:
    - name: KUBECTL_VERSION
      value: "1.20"
```

### Sleep Mode (version 0.2.0)

The image has a sleep mode integrated, which when activated allows the container to run endlessly until stopped from the outside. To use the sleep mode, you need to run the container with `sleep` as argument. This can be useful when debugging a pod from the inside.

#### Kubernetes Example for sleep mode

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: sleeper
spec:
  containers:
  - name: sleeper
    image: chronicc/cloudbox:0.2.0
    args:
    - sleep
```

## Development

This repository uses [Pants](https://www.pantsbuild.org/) to build and publish the container image.

* To build the image, run `GIT_TAG=<x.y.z> ./pants package :cloudbox`
* To publish the image, run `GIT_TAG=<x.y.z> ./pants publish :cloudbox`

## License

MIT
