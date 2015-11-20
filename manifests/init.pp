# = Class: cygwin
#
# This is a puppet module to install and manage Cygwin.
#
# == Parameters
#
# [*packages*]
#   Defines an array of packages to install after Cygwin is installed
#
class cygwin (
  $packages = {}
) inherits cygwin::params {

  include cygwin::install

  create_resources('cygwin::package', $packages)
}
