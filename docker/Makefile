# Copyright (c) 2017-2023 Trough Creek Holdings, LLC.  All Rights Reserved

ROOT=$(abspath ${CURDIR}/..)

SUBDIR=

DOCKER_CONTAINERS=$(shell ${ROOT}/mk/scripts/docker-deps -p ${DOCKER_NS} -f make list .)
DOCKER_REMOTE_CONTAINERS=$(shell ${ROOT}/mk/scripts/docker-deps -e production -l runtime.docker=true -p ${DOCKER_NS} -f make list .)
DOCKER_COMPOSITIONS=$(shell find ${CURDIR}/src -name 'compose-*.erb' | xargs -r -n 1 basename | sed -e 's;.yml.erb$$;;' -e 's;^compose-;;')

include ${ROOT}/mk/Makefile.vars
include ${ROOT}/mk/Makefile.ruby
include ${ROOT}/mk/Makefile.docker
include ${ROOT}/mk/Makefile.exports

-include Makefile.deps

all: docker_compile docker_build

list:
	@echo ${DOCKER_CONTAINERS}

list_remote:
	@echo ${DOCKER_REMOTE_CONTAINERS}

labels:
	docker inspect --format '{{json .Config.Labels}}' ${PACKAGE_NAME}:$(or ${C},api)-${REVISION}|jq

rebuild_api:
	${MAKE} docker_rebuild_api && ${MAKE} docker_remote_push && ${MAKE} docker_rebuild_api-dev && ${MAKE} docker_cleanup
