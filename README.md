#Cygwin

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

This module installs Cygwin and adds Cygwin as a package provider in Puppet.   

##Module Description

This module will download the Cygwin setup executable and install it. This will install the standard set of cygwin tools to the standard cygwin location.

##Usage

If you want to use cygwin as a package provider, it must be installed first.

###Install Cygwin

```puppet
include '::cygwin'
```

##Reference

###Classes

####Public Classes

* cygwin: Main Class, includes all other classes.

####Private Classes

###Parameters

##Limitations

For obvious reasons, this module will only work on the Windows operating system.

##Development

Please see the Puppet guidelines for module contribution. http://projects.puppetlabs.com/projects/module-site/wiki/Module_contributing
