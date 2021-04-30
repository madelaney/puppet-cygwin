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
    on_supported_os.each do |os, os_facts|
      context "on #{os} has necessary requirements" do
        let :params do default_params end
        let(:facts) do
          os_facts.merge({
            :caller_module_name => 'cygwin',
            :is_pe              => false
          })
        end
        it { is_expected.to contain_class('cygwin') }
        it { is_expected.to contain_class('cygwin::params') }
      end
    end
  end
end
