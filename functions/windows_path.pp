# Get a Windows path from a Cygwin path.
function cygwin::windows_path ( Stdlib::Unixpath $path ) >> Stdlib::Windowspath {
  # Needed to determine the Cygwin root directory
  include cygwin

  # Convert /cygrive/ paths, e.g. /cydrive/c/, to Windows paths, e.g. c:/
  $path2 = $path.regsubst('^/cygdrive/(\w+)', '\1:', 'I')

  if $path2 == $path {
    # It wasn't a /cygdrive/ path
    "${cygwin::install_root}${path2}".regsubst('/+', '\\', 'G')
  } else {
    $path2.regsubst('/+', '\\', 'G')
  }
}
