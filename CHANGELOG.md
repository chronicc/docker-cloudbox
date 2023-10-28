# Changelog

## 1.0.0

### Breaking Changes

- tfenv has been removed so `.terraform-version` files are not supported anymore. However you can add tfenv via the `ASDF_PLUGINS` variable if you rely on it.
- awscli, docker, kubectl and terraform have been removed as a hard dependency. They can be installed as additional packages if needed.
- The environment variable `KUBECTL_VERSION` is not supported anymore.

### Features

- The environment variable `APK_PACKAGES` has been added for installing additional apk packages.
- The environment variable `ASDF_PLUGINS` has been added for installing additional asdf plugins.

### Development

- The pants buildsystem has been replaced with plain make due to the simplicity of this repository.
- asdf is used to manage repository dependencies.
