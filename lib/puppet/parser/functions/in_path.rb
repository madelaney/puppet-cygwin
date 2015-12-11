require 'win32/registry'



module Puppet::Parser::Functions
  newfunction(:in_path, :type => :rvalue, :doc => <<-EOS
    Returns true if the path is in the path.
    EOS
  ) do |args|
    raise(Puppet::ParseError, "in_path(): Wrong number of arguments " +
      "given (#{args.size} for 1)") if args.size != 1

    keys = [
      {
        :HIVE => Win32::Registry::HKEY_CURRENT_USER,
        :PATH => 'Environment'
      },
      {
        :HIVE => Win32::Registry::HKEY_LOCAL_MACHINE,
        :PATH => 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment'
      }
    ]

    expected_path = args[0]
    reg_type = Win32::Registry::KEY_READ | 0x100

    found = false

    keys.each do |entires|
      entires[:PATH].split(':').each do |path|
        Puppet.debug "Opening '#{path}'"
        entires[:HIVE].open(path, reg_type) do |reg|
          begin
            regkey = reg['Path']
            parts = regkey.split(';')

            found = parts.include? expected_path
            break if found

          rescue StandardError => e
            Puppet.debug e

          end
        end
      end
    end

    found
  end
end
