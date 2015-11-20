Facter.add(:cygwin_installed) do
  confine :osfamily => :windows

  setcode do
    installed = File.exist?('C:\cygwin64') || File.exist?('C:\cygwin')
    installed
  end
end
