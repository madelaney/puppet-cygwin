require 'spec_helper'

provider_class = Puppet::Type.type(:package).provider(:cygwin)

CYGCHECK_OUTPUT = %(
Cygwin Package Information
Package              Version
gcc-g++              5.3.0-3
openssh              7.2p1-1
ncurses              6.0-4.20160305
ncurses1             6.0
).freeze

describe provider_class do
  let(:resource) do
    Puppet::Type.type(:package).new(
      name: 'myresource',
      ensure: :installed,
    )
  end

  let(:provider) do
    provider = provider_class.new
    provider.resource = resource
    provider
  end

  before :each do
    resource.provider = provider
  end

  def expect_execute(command, status)
    provider.expects(:execute).with(command, execute_options).returns(Puppet::Util::Execution::ProcessOutput.new('', status))
  end

  describe 'provider features' do
    it { is_expected.to be_versionable }
    it { is_expected.to be_uninstallable }
    it { is_expected.to be_installable }
    it { is_expected.to be_install_options }
  end

  [:cygcheck, :cygwin, :parse_cygcheck_line, :hash_from_line].each do |method|
    it "responds to the class method #{method}" do
      expect(provider_class).to respond_to(method)
    end
  end

  context '::cygcheck' do
    it 'parses a single version string' do
      pkg = {
        name: 'ncurses1',
        version: '6.0',
        provider: :cygwin,
        ensure: '6.0'
      }
      parsed = provider_class.parse_cygcheck_line(%(ncurses1             6.0))
      expect(parsed).to eq(pkg)
    end

    it 'parses a version with patch' do
      pkg = {
        name: 'gcc-g++',
        version: '5.3.0-3',
        provider: :cygwin,
        ensure: '5.3.0-3'
      }
      parsed = provider_class.parse_cygcheck_line(%(gcc-g++              5.3.0-3))
      expect(parsed).to eq(pkg)
    end

    it 'parses a version with characters' do
      pkg = {
        name: 'openssh',
        version: '7.2p1-1',
        provider: :cygwin,
        ensure: '7.2p1-1'
      }
      parsed = provider_class.parse_cygcheck_line(%(openssh              7.2p1-1))
      expect(parsed).to eq(pkg)
    end

    it 'parses a version with extended revision' do
      pkg = {
        name: 'ncurses',
        version: '6.0-4.20160305',
        provider: :cygwin,
        ensure: '6.0-4.20160305'
      }
      parsed = provider_class.parse_cygcheck_line(%(ncurses              6.0-4.20160305))
      expect(parsed).to eq(pkg)
    end
  end
end
