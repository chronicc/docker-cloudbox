GIT_TAG ?=

ifndef ($(GIT_TAG))
GIT_TAG=$(shell git describe --tags `git rev-list --tags --max-count=1`)
endif

build:
	./pants lint Dockerfile
	GIT_TAG=$(GIT_TAG) ./pants package :cloudbox

publish:
	GIT_TAG=$(GIT_TAG) ./pants publish :cloudbox
