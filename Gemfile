source ENV['GEM_SOURCE'] || "https://rubygems.org"

puppetversion = ENV.key?('PUPPET_VERSION') ? "= #{ENV['PUPPET_VERSION']}" : ['>=4.1.0', '<7.0.0']

# NOTE Needed for compat.
#
# Rake 11.0, removes the field last_comment. This breaks some Puppet rspec
# behaviors so we'll pin the version to work around this.
#
gem 'rake', '< 11.0'

gem 'puppet', puppetversion
gem 'facter', '>= 1.7.0'
gem 'safe_yaml'

group :development, :unit_tests do
  gem 'metadata-json-lint'
  gem 'puppet-lint', '>= 0.3.2'
  gem 'pdk', '>= 1.8.0'

  gem 'rspec-core', '3.1.7',     :require => false
  gem 'puppetlabs_spec_helper',  :require => false
  gem 'simplecov',               :require => false
  gem 'puppet_facts',            :require => false
  gem 'json',                    :require => false
end

group :system_tests do
  gem 'beaker-rspec',  :require => false
  gem 'serverspec',    :require => false
  gem 'beaker-puppet_install_helper', :require => false
end

# vim:ft=ruby
