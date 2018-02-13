# Copyright (c) 2017, 2018 Trough Creek Holdings, LLC.  All Rights Reserved

ROOT=$(abspath ${CURDIR}/..)

SUBDIR=

DOCKER_CONTAINERS=$(shell ${ROOT}/bin/docker-deps -p ${DOCKER_NS} -f make list .)
DOCKER_REMOTE_CONTAINERS=$(shell ${ROOT}/bin/docker-deps -e production -p ${DOCKER_NS} -f make list .)
DOCKER_COMPOSITIONS=$(shell ls ${CURDIR}/src/compose-*.erb | xargs -n 1 basename | sed -e 's;.yml.erb$$;;' -e 's;^compose-;;')

include ${ROOT}/mk/Makefile.vars
include ${ROOT}/mk/Makefile.ruby
include ${ROOT}/mk/Makefile.docker

-include Makefile.deps

all: docker_compile docker_build

list:
	@echo ${DOCKER_CONTAINERS}

list_remote:
	@echo ${DOCKER_REMOTE_CONTAINERS}
