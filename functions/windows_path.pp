# Get a Windows path from a Cygwin path.
function cygwin::windows_path ( Stdlib::Unixpath $path ) >> Stdlib::Windowspath {
  # Convert /cygrive/ paths, e.g. /cydrive/c/, to Windows paths, e.g. c:/
  $path2 = $path.regsubst('^/cygdrive/(\w+)', '\1:', 'I')

  # Convert all / to \
  $path3 = $path2.regsubst('/+', '\\', 'G')

  if $facts['cygwin_home'] !~ String[1] {
    # If this happens, this function could generate bad paths.
    fail('Function cygwin::windows_path requires cygwin_home fact. It should be set by this module.')
  }

  if $path2 == $path {
    # It wasn't a /cygdrive/ path
    "${facts['cygwin_home']}${path3}"
  } else {
    $path3
  }
}
