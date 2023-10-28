GIT_TAG ?=

ifndef ($(GIT_REV))
GIT_REV=$(shell git rev-parse --short HEAD)
endif

ifndef ($(GIT_TAG))
GIT_TAG=$(shell git describe --tags `git rev-list --tags --max-count=1`)
endif

.PHONY: build publish run test

build:
	hadolint Dockerfile
	docker build --build-arg="GIT_REV=$(GIT_REV)" --build-arg="GIT_TAG=$(GIT_TAG)" -t chronicc/cloudbox:$(GIT_TAG) .

run: build
	docker run -it --rm -v .:/repo chronicc/cloudbox:$(GIT_TAG) bash

test: build
	docker run \
		--rm \
		-v .:/repo \
		--env "APK_PACKAGES=mysql-client,python3,py3-pip" \
		--env "ASDF_PLUGINS=kubectl=latest,terraform=1.4.0" \
		chronicc/cloudbox:$(GIT_TAG) \
		bash -c 'pip install pytest-testinfra && py.test -v /repo/tests'

publish: test
	docker push chronicc/cloudbox:$(GIT_TAG)
