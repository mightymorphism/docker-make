# Copyright (c) 2017, 2018 Trough Creek Holdings, LLC.  All Rights Reserved
#
# Make ruby_* dependency of non-ruby version
$(foreach _, init check clean nuke reset, $(eval $_: ruby_$_))
$(foreach _, init check clean nuke reset, $(eval .PHONY: ruby_$_))

ruby_check:
	@if [ -z "$${RBENV_VERSION}" ] ; then				\
		echo "rbenv not (properly) activated" 1>&2 ;		\
		exit 1 ;						\
	fi
	@if [ "$${BUNDLE_GEMFILE}" != "${ROOT}/Gemfile" ]; then		\
		echo "bundler not (properly) configured" 1>&2 ;		\
		exit 1 ;						\
	fi

ruby_init:

ruby_clean:
	#bundle clean --force

ruby_nuke: ruby_clean

ruby_reset: ruby_clean
