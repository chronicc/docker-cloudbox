GIT_TAG ?=

ifndef ($(GIT_TAG))
GIT_TAG=$(shell git describe --tags `git rev-list --tags --max-count=1`)
endif

.PHONY: build publish

build:
	hadolint Dockerfile
	docker build --build-arg="GIT_TAG=${GIT_TAG}" -t chronicc/cloudbox:$(GIT_TAG) .

publish:
	docker publish chronicc/cloudbox:$(GIT_TAG) .
