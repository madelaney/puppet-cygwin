Facter.add(:cygwin_home) do
  confine :osfamily => :windows

  PATHS = ['C:\Cygwin64', 'C:\Cygwin']
  setcode do
    path = nil
    PATHS.each do |p|
      path = p if File.exist? p
      break
    end

    path
  end
end
