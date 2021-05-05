Facter.add(:cygwin_installed) do
  confine :os do |os|
    os['family'] == 'windows'
  end

  setcode do
    installed = File.exist?('C:\cygwin64') || File.exist?('C:\cygwin')
    installed
  end
end
