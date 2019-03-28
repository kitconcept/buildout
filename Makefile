# keep in sync with: https://github.com/kitconcept/buildout/edit/master/Makefile
# update by running 'make update'
SHELL := /bin/bash
CURRENT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

version = 2.7

# We like colors
# From: https://coderwall.com/p/izxssa/colored-makefile-for-golang-projects
RED=`tput setaf 1`
GREEN=`tput setaf 2`
RESET=`tput sgr0`
YELLOW=`tput setaf 3`

all: .installed.cfg
	bin/test

# Add the following 'help' target to your Makefile
# And add help text after each target name starting with '\#\#'
.PHONY: help
help: ## This help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

update:
	wget -O Makefile https://raw.githubusercontent.com/kitconcept/buildout/master/Makefile
	wget -O requirements.txt https://raw.githubusercontent.com/kitconcept/buildout/master/requirements.txt
	wget -O plone-4.3.x.cfg https://raw.githubusercontent.com/kitconcept/buildout/master/plone-4.3.x.cfg
	wget -O plone-5.1.x.cfg https://raw.githubusercontent.com/kitconcept/buildout/master/plone-5.1.x.cfg
	wget -O plone-5.2.x.cfg https://raw.githubusercontent.com/kitconcept/buildout/master/plone-5.2.x.cfg

.installed.cfg: bin/buildout *.cfg
	bin/buildout

bin/buildout: bin/pip
	bin/pip install --upgrade pip
	bin/pip install -r requirements.txt
	@touch -c $@

build-plone-4.3: .installed.cfg
	bin/pip install --upgrade pip
	bin/pip install -r requirements.txt
	bin/buildout -c plone-4.3.x.cfg

build-plone-5.0: .installed.cfg
	bin/pip install --upgrade pip
	bin/pip install -r requirements.txt
	bin/buildout -c plone-5.0.x.cfg

build-plone-5.1: .installed.cfg
	bin/pip install --upgrade pip
	bin/pip install -r requirements.txt
	bin/buildout -c plone-5.1.x.cfg
	
build-plone-5.2: .installed.cfg
	bin/pip install --upgrade pip
	bin/pip install -r requirements.txt
	bin/buildout -c plone-5.2.x.cfg

build-py3:
	virtualenv --python=python3 .
	bin/pip install --upgrade pip
	bin/pip install -r requirements.txt
	bin/buildout -c plone-5.2.x.cfg

bin/python bin/pip:
	virtualenv --clear --python=python$(version) .

test:
	bin/test

release:
	bin/fullrelease

clean:
	git clean -Xdf

.PHONY: all clean
