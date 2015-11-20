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
define cygwin::package($ensure = 'present', $source = nil) {
  require cygwin

  package {
    $name:
      ensure    => $ensure,
      provider  => 'cygwin',
      source    => $source,
      require   => Class['cygwin'];
  }
}
