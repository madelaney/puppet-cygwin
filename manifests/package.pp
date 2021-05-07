# = Define: cygwin::package
#
# Installs a package by means of Cygwin
#
# == Parameters
#
# [*name*]
#   The name of the package to install
#
# [*ensure*]
#   Ensure the package is present or absenet.
#
# [*source*]
#   The Cygwin mirror to install the package from
#
# [*proxy*]
#   The internet proxy settings to use when installing a package
#
define cygwin::package (
  $ensure = 'present',
  $source = undef,
  $proxy  = $cygwin::proxy
) {
  # The base class must be included first because it is used by parameter defaults
  if ! defined(Class['cygwin']) {
    fail('You must include the Cygwin base class before using any packages')
  }

  $_final_install_options = $proxy ? {
    undef   => undef,
    default => "-p ${proxy}",
  }

  package {
    $name:
      ensure          => $ensure,
      provider        => 'cygwin',
      source          => $source,
      install_options => $_final_install_options;
  }
}
