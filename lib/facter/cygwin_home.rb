Facter.add(:cygwin_home) do
  confine :osfamily => :windows

  setcode do
    ['C:\Cygwin64', 'C:\Cygwin'].find {|path| File.exist? path}
  end
end
