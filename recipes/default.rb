#
# Cookbook Name:: lib-shibboleth
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

shib = node['shibboleth']

cookbook_file "/etc/yum.repos.d/tamulib.repo" do
  source "tamulib.repo"
  mode 0644
end

yum_package 'apr' do
  flush_cache [:before]
  action :upgrade
end

yum_package 'apr-util' do
  action :upgrade
end

yum_package 'httpd'
yum_package 'shibboleth'

execute '/sbin/ldconfig' do
  action :nothing
end

cookbook_file '/etc/ld.so.conf.d/shibboleth.so.conf' do
  source 'shibboleth.so.conf'
  notifies :run, 'execute[/sbin/ldconfig]', :immediately
end

service 'httpd' do
  action [:start, :enable]
  supports :restart => true
end

service 'shibd' do
  action [:start, :enable]
  supports :restart => true
end

template '/etc/httpd/conf/httpd.conf' do
  source 'httpd.conf.erb'
  variables(
    :node => node
  )
  notifies :restart, 'service[httpd]', :delayed
end

template '/etc/shibboleth/shibboleth2.xml' do
  source 'shibboleth2.xml.erb'
  owner shib['user']
  group shib['group']
  variables(
    :shib => shib
  )
  notifies :restart, 'service[httpd]', :delayed
  notifies :restart, 'service[shibd]', :delayed
end

template '/etc/shibboleth/attribute-map.xml' do
  source 'attribute-map.xml.erb'
  owner shib['user']
  group shib['group']
  variables(
    :attributes => shib['attributes']
  )
  notifies :restart, 'service[shibd]', :delayed
end

remote_file '/etc/shibboleth/federation.tamu.edu.crt' do
  source shib['fedcert']
  owner shib['user']
  group shib['group']
  mode 0700
  notifies :restart, 'service[shibd]', :delayed
end

remote_file File.join("/etc/shibboleth/","#{shib['servername']}-crt.pem") do
  only_if { shib['fetchcert'] }
  source URI.join(shib['certrepo'], "#{shib['servername']}-crt.pem").to_s
  owner shib['user']
  group shib['group']
  mode 0700
  notifies :restart, 'service[shibd]', :delayed
end

remote_file File.join("/etc/shibboleth/","#{shib['servername']}-key.pem") do
  only_if { shib['fetchcert'] }
  source URI.join(shib['certrepo'], "#{shib['servername']}-key.pem").to_s
  owner shib['user']
  group shib['group']
  mode 0700
  notifies :restart, 'service[shibd]', :delayed
end
