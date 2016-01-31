#
# Cookbook Name:: hello
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

ruby_runtime 'any' do
  provider :system
  version ''
end

ruby_gem 'rack' do
  version '1.6.1'
end

package value_for_platform_family(debian: 'ruby-dev', rhel: 'ruby-devel')
package value_for_platform_family(debian: 'zlib1g-dev', rhel: 'zlib-devel')
package value_for_platform_family(debian: 'libsqlite3-dev', rhel: 'sqlite-devel')
package 'tar' if platform_family?('rhel')


application '/opt/hello_app' do
  git 'https://github.com/jeremyolliver/hello_app.git'
  bundle_install do
    deployment true
    without %w{development test}
  end

  rackup do
    port 8000
  end
end


