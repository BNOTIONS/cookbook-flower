#/
# Cookbook Name:: flower
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

include_recipe 'build-essential'
include_recipe 'python'

python_virtualenv 'flower-virtualenv' do
  owner node[:flower][:user]
  path node[:flower][:virtualenv]
  not_if { node[:flower][:skip_install] or node[:flower][:virtualenv].nil? }
end

python_pip 'flower' do
  version node[:flower][:version]
  virtualenv node[:flower][:virtualenv]
  action :install
  not_if { node[:flower][:skip_install] }
end

python_pip 'pyopenssl' do
  virtualenv node[:flower][:virtualenv]
  action :install
  not_if { node[:flower][:skip_install] or !node[:flower][:ssl_cert] }
end

broker_url = sprintf("%s://%s:%s@%s:%d/%s",
  node[:flower][:broker][:protocol],
  node[:flower][:broker][:username],
  node[:flower][:broker][:password],
  node[:flower][:broker][:host],
  node[:flower][:broker][:port],
  node[:flower][:broker][:vhost]
)

flower_cmd = sprintf("flower --address=%s --port=%s --broker='%s'",
  node[:flower][:listen_address],
  node[:flower][:listen_port],
  broker_url
)

if node[:flower][:ssl_cert]
  flower_cmd = sprintf("%s --certfile='%s' --keyfile='%s'",
    flower_cmd,
    node[:flower][:ssl_cert],
    node[:flower][:ssl_key]
  )
end

if node[:flower][:auth]
  flower_cmd = sprintf("%s --auth='%s'",
    flower_cmd,
    node[:flower][:auth]
  )
elsif node[:flower][:basic_auth]
  flower_cmd = sprintf("%s --basic_auth='%s'",
    flower_cmd,
    node[:flower][:basic_auth]
  )
end

include_recipe 'supervisor'

supervisor_service 'flower' do
  user node[:flower][:user]
  autostart node[:flower][:autostart]
  autorestart node[:flower][:autorestart]
  command node[:flower][:virtualenv] ? "#{node[:flower][:virtualenv]}/bin/#{flower_cmd}" : flower_cmd
  directory "#{node[:flower][:virtualenv]}/bin" if node[:flower][:virtualenv]
  environment ({ "PATH" => "#{node[:flower][:virtualenv]}/bin" }) if node[:flower][:virtualenv]
  action :enable
end

