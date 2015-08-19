#
# Author:: Josh Beauregard <josh.beauregard@knectar.com>
# Cookbook Name:: nginx_drupal
# Provider:: drupal_instance
#
require 'uri'

def primary_url
  return @new_resource.url[0]
end
def shortname
  return primary_url.URI.parse.host.gsub(/^www\./, '').slice[0, 6]
end
def site_alias
  return "#{shortname}.#{@new_resource.instance}"
end
def server_name
  s.array.new()
  @new_resource.url.each {|u| s[] = u.URI.parse.host}
  return s.join(' ')
end

def app_path
  if @new_resource.app_path.empty?
    return "/srv/www/#{site_alias}"
  else
    return @new_resource.app_path
  end
end

def passwd_file
  return "/home/#{site_alias}-#{@new_resource.app_owner}/passwd"
end

action :create do
  #todo: create file system
  #application directory
  directory app_path do
    owner @new_resource.app_ower
    group @new_resource.app_ower
    mode '0755'
    recursive TRUE
    action :create
  end

  #public files
  directory "#{app_path}/#{@new_resource.public_files}" do
    owner node['nginx']['user']
    group node['nginx']['user']
    mode '0755'
    action :create
  end
  #private files
  directory "#{app_path}/#{@new_resource.private_files}" do
    owner node['nginx']['user']
    group node['nginx']['user']
    mode '0755'
    action :create
  end
  ## create passwd file
  template passwd_file do
    source 'blank.erb'
    owner @new_resource.app_owner
    group @new_resource.app_owner
    mode '0644'
    variables(content: passwd.join('\n'))
  end

  

  ## create vhost file
  template "/etc/nginx/sites-enabled/#{site_alias}.conf" do
    source 'vhost.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      ssl_crt: @new_resource.ssl_crt,
      ssl_key: @new_resource.ssl_key,
      ssl_chain: @new_resource.ssl_chain,
      url: server_name,
      app_path: app_path,
      passwd_file: passwd_file,
      passwd_text: @new_resource.passwd_text,
      private_dir: @new_resource.private_dir
    )
    action :create
  end
  #todo: create add ssl
  #todo: create database
  #todo: create drush alieas
  Chef::Log.info("created drupal_instance")
  new_resource.updated_by_last_action(true)
end
action :delete do
  #todo: delete file system
  #todo:delete vhost file
  #todo: delete database
  #todo: delete drush alieas
  cookbook_file '/etc/cron.hourly/drupal.cron.sh' do
    source 'drupal.cron.sh'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
  end
  Chef::Log.info("deleted drupal_instance")
  new_resource.updated_by_last_action(true)
end
