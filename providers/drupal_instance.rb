#
# Author:: Josh Beauregard <josh.beauregard@knectar.com>
# Cookbook Name:: nginx_drupal
# Provider:: drupal_instance
#
require 'uri'
require 'securerandom'

use_inline_resources if defined?(use_inline_resources)


def primary_url
  return @new_resource.url.first
end
def shortname
  uri = URI(primary_url)
  return uri.host.to_s.gsub(/^www\./, '').slice(0, 6)
end
def site_alias
  return "#{shortname}.#{@new_resource.instance}"
end
def server_name
  return new_resource.url.join(' ')
end

def app_path
  if @new_resource.app_path.nil?
    return "/srv/www/#{site_alias}"
  else
    return @new_resource.app_path
  end
end

def passwd_file
  return "/home/#{site_alias}-#{app_owner}/passwd"
end

def passwd
  if @new_resource.passwd.nil?
    return Array.new
  else
    return @new_resource.passwd
  end
end

def db
  db = Hash.new
  @new_resource.db.to_hash.each do |k, v|
    case k
    when 'host'
      db[k] = v
    when 'db' || 'user' 
      db[k] = (v.nil? && site_alias) || v
    when 'password'
      db[k] = SecureRandom.hex(20)
    when 'prefix'
      db[k] = (v.nil? && '') || v
    end

  end
end
def mysql_connection_info  
  return {
    :host => @new_resource.db['host'],
    :username => 'root',
    :password => node['nginx_drupal']['mysql']['root_password']
  }
end

def app_owner
  if @new_resource.app_owner.nil?
   return site_alias
  else
    return @new_resource.app_owner
  end
end

action :create do
  #todo: create file system
  #application directory
  directory app_path do
    owner app_owner
    group app_owner
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
    owner app_owner
    group app_owner
    mode '0644'
    not_if { passwd.empty? }
    variables(content: passwd.join('\n'))
  end

  ## drupal settings file
  template "#{app_path}/sites/#{@new_resource.sites_directory}/settings.php" do
    source 'settings.php.erb'
    owner app_owner
    group app_owner
    mode '0444'
    variables(
       db: site_alias,
       db_host: db['host'],
       db_user: db['user'],
       db_password: db['password'],
       db_prefix: db['prefix'],
       extra_settings: new_resource.extra_settings
    )
  end

  ## create vhost file
  template "/etc/nginx/sites-enabled/#{site_alias}.conf" do
    source 'vhost.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      ssl_crt: new_resource.ssl_crt,
      ssl_key: new_resource.ssl_key,
      ssl_chain: new_resource.ssl_chain,
      url: server_name,
      primary_url: primary_url,
      app_path: app_path,
      passwd_file: passwd_file,
      passwd_text: new_resource.passwd_text,
      private_files: new_resource.private_files
    )
    action :create
    notifies :restart, 'service[nginx]', :delayed
  end
  #todo: create add ssl
  #todo: create database
  mysql_database site_alias do
    connection mysql_connection_info
    action :create
  end

mysql_database_user site_alias do
  connection mysql_connection_info
  password db_password 
  database_name site_alias
  action :create
end

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
