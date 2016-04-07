require 'spec_helper'

describe 'cygwin', :type => :class do
  context "on Any OS" do
    let :facts do
      {
        :id       => 'root',
        :kernel   => 'Windows',
        :osfamily => 'Windows'
      }
    end

    it { is_expected.to contain_class("cygwin::params") }
  end

end
