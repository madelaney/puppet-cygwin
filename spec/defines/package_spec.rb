require 'spec_helper'

describe 'cygwin::package', :type => :define do
  let :pre_condition do
    'class { "cygwin": } '
  end

  let :title do
    'cygwin.example.com'
  end

  let :default_params do
    {
      :proxy => 'http://corpproxy:8090'
    }
  end

  describe 'simple setup' do
    context "has necessary requirements" do
      let :default_facts do
        {
          :caller_module_name => 'cygwin',
          :osfamily => 'Windows',
          :kernel   => 'Windows',
          :is_pe    => false
        }
      end

      let :params do default_params end
      let :facts do default_facts end

      it { is_expected.to contain_class('cygwin') }
      it { is_expected.to contain_class('cygwin::params') }
    end
  end
end
