# docker-make

This repository contains a set of shell scripts and GNU Makefiles to
drive a simple docker build workflow with a local docker-compose based
development environment and the ability to push containers to a remote
Docker registry (in this implementation, ECR and Heroku).

Configuration goes in ``mk/Makefile.cfg``.  Local changes and
overrides that don't belong in the repository can be placed in
``mk/Makefile.cfg.local``.

# Dependencies

1. Some targets assume that ``jq`` is available
2. Currently assumes that ``realpath`` from ``coreutils`` 8.25 or later is available.

# Make targets

- all		- do it all; recursively if necessary
- build		- invoke build process (but not, e.g. pushing of packages)
- check		- recursively calls check for language-specific modules, which check availability of necessary build tools and versions
- clean		- clean up after ourselves; not as aggressive as nuke
- nuke		- nuke it from orbit; it is the only way to be sure
- depend	- generate dependencies
- docker\_bootstrap\_init
- docker\_build	- run the docker build process
- docker\_build\_force(\_\*)	- override deps and JFDI
- docker\_cleanup	- more than clean; less than nuke -- everything but volumes
- docker\_compile	- compile dockerb templates into Dockerfiles in build directory
- docker\_images	- list local images in the current ${DOCKER\_NS}
- docker\_labels	- list labels on current default image; override to alternate image with C=<image-name>
- docker\_login		- log in to configured remote docker registry
- docker\_logout	- log out of configured remote docker registry
- docker\_tag(\_\*)	- tag docker named docker image (or all)
- docker\_nuke(\_\*)	- nuke named docker image (or all)
- docker\_rebuild(\_\*)	- force re-build of named docker image (or all)
- docker\_remote\_list	- directly query remote registry for images
- docker\_remote\_push(\_\*)	- push images marked as "remote" to registry
- docker\_remote\_tag(\_\*)	- push tags for "remote" images to registry

# Using git subtree to merge into other projects

Instead of manually tracking this repository, if you have few/no changes to
the core functionality, you can use ``git subtree`` to merge it into your
repository.  One way to do so is to check out a copy of this repo and run:

```
docker-make$ git subtree split --prefix=mk --annotate="[mk] " -b mk
```

Then in your repository, assuming it is in a parallel directory, ``repo``:

```
repo$ git subtree add --prefix=mk --squash ../docker-make mk
```
