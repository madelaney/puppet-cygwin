# = Define: cygwin::params
#
# Smart params class for Cygwin.
#
# == Parameters
#
class cygwin::params {
  $host = 'http://cygwin.com/'
  $mirror = 'http://cygwin.mirror.constant.com'
  $proxy = undef

  case $facts['os']['hardware'] {
    'x64','x86_64': {
      $install_root = 'C:/Cygwin64'
      $installer = 'setup-x86_64.exe'
    }
    default: {
      $install_root = 'C:/Cygwin'
      $installer = 'setup-x86.exe'
    }
  }
}
