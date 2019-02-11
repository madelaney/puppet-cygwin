require 'puppet/util/feature'

# Ensure that Cygwin is installed and ready to go.
Puppet.features.add(:cygwin) do
  return false if ! Puppet::Util::Platform.windows?

  begin
    require 'Win32API'
    require 'win32/registry'
  rescue LoadError => e
    Puppet.warning("Cygwin packages need the win32-registry gem: #{e}")
    return false
  end

  install_dir = nil
  begin
    Win32::Registry::HKEY_LOCAL_MACHINE.open('SOFTWARE\Cygwin\setup') do |reg|
      install_dir = reg['rootdir'].tr '/', '\\'
    end
  rescue StandardError => e
    Puppet.debug("Cygwin packages need SOFTWARE\\Cygwin\\setup in the registry: #{e}")
    return false
  end

  Puppet::FileSystem.executable?(File.join install_dir, 'bin', 'cygcheck.exe') \
    && Puppet::FileSystem.executable?(File.join install_dir, 'bin', 'setup.exe')
end
