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
# [*proxy*]
#   The HTTP proxy (host:port) settings to use when installing packages
#
#
class cygwin::install(
  $install_root = $cygwin::install_root,
  $host         = $cygwin::host,
  $mirror       = $cygwin::mirror,
  $proxy        = $cygwin::proxy,
  $installer    = $cygwin::installer
) inherits cygwin {
  file {
    $install_root:
      ensure => directory;
  }

  $_final_url = "${host}/${installer}"
  staging::file {
    $installer:
      source => $_final_url,
      notify => Exec['Install Cygwin'];
  }

  file {
    "${::staging_windir}\\cygwin\\${installer}":
      mode    => '0755',
      require => Staging::File[$installer];
  }

  $_final_command_args = $proxy ? {
    undef   => "-q -R ${install_root} -s ${mirror}",
    default => "-q -R ${install_root} -s ${mirror} -p ${proxy}",
  }

  exec {
    'Install Cygwin':
      command => "${installer} ${_final_command_args}",
      cwd     => "${::staging_windir}\\cygwin",
      path    => ["${::staging_windir}\\cygwin"],
      creates => "${install_root}\\Cygwin.bat",
      require => [
        File[$install_root],
        File["${::staging_windir}\\cygwin\\${installer}"],
      ];
  }

  # NOTE (madelaney)
  # In order to uninstall/install any packages we need a copy of the 'setup' binary,
  # so we'll copy this to Cygwin so we have something we can rely on.
  #
  file {
    "${install_root}\\bin\\setup.exe":
      ensure             => file,
      source             => "${::staging_windir}\\cygwin\\${installer}",
      source_permissions => ignore,
      mode               => '0755',
      require            => Exec['Install Cygwin'];
  }
}
