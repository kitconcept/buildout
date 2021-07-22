.. image:: https://github.com/kitconcept/buildout/actions/workflows/ci.yml/badge.svg
  :target: https://github.com/kitconcept/buildout

kitconcept Buildout
===================

Basic Python 3, Plone 5.2 Buildout setup with the kitconcept best practices.
This buildout base is used in all the open source projects we help to maintain.

Rationale
---------

CI systems should be stable and not rely on external resources that are subject to change. 
Approaches like buildout.plonetest violate this principle and make the CI build fragile.
The build can fail at any time without notice when an external resource changes.

Getting started
---------------

Fetch Makefile::

    wget -O Makefile https://raw.githubusercontent.com/kitconcept/buildout/5.2/Makefile

Update Buildout files::

    make update

This will automatically update the following files in your local folder:

- Makefile
- requirements.txt
- plone-5.2.x.cfg
- versions.cfg (versions that are used for all Plone versions except Plone 5.2)
- ci.cfg (CI configuration for GitHub actions)

kitconcept Buildout expects a base.cfg configuration to be present in your buildout that contains your customizations and contains the following parts (replace collective.embeddedpage with your add-on)::

    [buildout]
    index = https://pypi.org/simple
    show-picked-versions = true
    extensions = mr.developer
    parts =
        instance
    develop = .
    versions = versions

    [instance]
    recipe = plone.recipe.zope2instance
    user = admin:admin
    http-address = 8080
    eggs =
        Plone
        Pillow
        collective.embeddedpage [test]

    [versions]
    # Don't use a released version of collective.embeddedpage
    collective.embeddedpage =

    # setuptools / buildout
    setuptools =
    zc.buildout =
    zc.recipe.egg = 2.0.3


Make Commands
-------------

Available make commands:

- Update Makefile and Buildout: make update
- Build Plone 5.2.x: make build-plone-5.2
