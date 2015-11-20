# = Class: cygwin::install
#
# Installs Cygwin and setups the mirror for future packages
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
class cygwin::install(
  $install_root = $cygwin::params::install_root,
  $host = $cygwin::params::host,
  $mirror = $cygwin::params::mirror,
) inherits cygwin {
  file {
    $install_root:
      ensure => directory;
  }

  $_final_url = "${host}/${cygwin::params::installer}"
  staging::file {
    $cygwin::params::installer:
      source => $_final_url,
      notify => Exec['Install Cygwin'];
  }

  file {
    "${::staging_windir}\\cygwin\\${cygwin::params::installer}":
      mode    => '0755',
      require => Staging::File[$cygwin::params::installer];
  }

  $_final_command_args = "-q -R ${install_root} -s ${mirror}"

  exec {
    'Install Cygwin':
      command     => "${cygwin::params::installer} ${_final_command_args}",
      cwd         => "${::staging_windir}\\cygwin",
      path        => ["${::staging_windir}\\cygwin"],
      loglevel    => debug,
      refreshonly => false;
  }

  # NOTE (madelaney)
  # In order to uninstall/install any packages we need a copy of the 'setup' binary,
  # so we'll copy this to Cygwin so we have something we can rely on.
  #
  file {
    "${install_root}\\bin\\setup.exe":
      ensure  => file,
      source  => "${::staging_windir}\\cygwin\\${cygwin::params::installer}",
      source_permissions => ignore,
      mode    => '0755';
  }

  if !in_path($install_root) {
    debug("Cygwin install path '${install_root}' is not in the path")
  }
}
