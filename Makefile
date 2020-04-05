# Environment
ROOT_PATH = $(abspath . )
VERSION = $(shell git describe --tags 2>/dev/null | echo -e "1.0.1")
PKG_NAME = $(shell basename `git rev-parse --show-toplevel`)
GOBUILD = GO111MODULE=on go build
BUILD_DIR = $(ROOT_PATH)/bin
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
	SHELL=/usr/local/bin/bash
else
	SHELL=/bin/bash
endif
.SHELLFLAGS = -o pipefail -O globstar -c

.PHONY: deps
deps:
	go mod tidy

.PHONY: build
build: deps
	$(GOBUILD) -o $(BUILD_DIR)/gwa -gcflags "all=-N -l" create-go-web-app