class { 'cygwin': }

cygwin::package {
  'name':
    proxy => 'http://localproxy:8080'
}
