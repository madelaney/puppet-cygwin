Facter.add(:cygwin_version) do
  confine :os do |os|
    os['family'] == 'windows'
  end

  setcode do
    version = nil
    begin
      version = Facter::Util::Resolution.exec 'uname -r'
    rescue
      Puppet.debug 'Unable to execute "uname -r", maybe uname is not installed?'
    end

    version
  end
end
