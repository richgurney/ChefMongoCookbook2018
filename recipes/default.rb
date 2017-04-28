# 
#
# Cookbook:: mongo-server
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


# update the keys
execute 'key-update' do
  command 'apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927'
end

file '/etc/apt/sources.list.d/mongodb-org-3.2.list' do
  content 'deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse'
  mode '0755'
  owner 'root'
  group 'root'
end

apt_update 'update' do
  action :update
end

package 'mongodb-org'


template '/lib/systemd/system/mongod.service' do
  source 'mongod.service.erb'
  mode '0755'
  owner 'root'
  group 'root'
end

template '/etc/mongod.conf' do
  source 'mongod.conf.erb'
  mode '0755'
  owner 'root'
  group 'root'
end

service 'mongod' do 
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end




