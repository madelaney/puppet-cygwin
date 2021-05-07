Facter.add(:cygwin_home) do
  confine :os do |os|
    os['family'] == 'windows'
  end

  setcode do
    ['C:\Cygwin64', 'C:\Cygwin'].find { |path| File.exist? path }
  end
end
