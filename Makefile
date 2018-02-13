# Copyright (c) 2017, 2018 Trough Creek Holdings, LLC.  All Rights Reserved

ROOT=$(abspath ${CURDIR})

SUBDIR=docker

include ${ROOT}/mk/Makefile.vars
include ${ROOT}/mk/Makefile.ruby
include ${ROOT}/mk/Makefile.docker
include ${ROOT}/mk/Makefile.compose
