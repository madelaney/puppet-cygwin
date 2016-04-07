# = Class: cygwin
#
# This is a puppet module to install and manage Cygwin.
#
# == Parameters
#
# [*install_root*]
#   The root of the Cygwin install, this defaults to 'C:\Cygwin' on
#   x86 systems, and 'C:\Cygwin64' on x86_64 systems.
#
# [*host*]
#   The Cygwin host to download Cygwin setup binary from

# [*mirror*]
#   The host to set the Cygwin mirror to. This will default to where all
#   future packages are installed from.
#
# [*proxy*]
#   The HTTP proxy (host:port) settings to use when installing packages
#
# [*packages*]
#   Defines an array of packages to install after Cygwin is installed
#
class cygwin (
  $install_root = $cygwin::params::install_root,
  $host         = $cygwin::params::host,
  $mirror       = $cygwin::params::mirror,
  $proxy        = $cygwin::params::proxy,
  $installer    = $cygwin::params::installer,
  $packages     = {},
) inherits cygwin::params {

  include cygwin::install

  create_resources('cygwin::package', $packages)
}
