require 'chef/provider/lwrp_base'
require 'uri'
class Chef
  class NginxDrupalInstanceBase < Chef::Provider::LWRPBase
    use_inline_resources if defined?(use_inline_resources)

    # variables
    # url could be array if it is the first is the primary
    # instance 
    # ssl files todo: find cookbook for with LWRP for this
    # password protected bool
    # password protected string
    # path
    # public files
    # private files
    # db password to be randomly generated.

    def primary_url
      if new_resource.url.is_a?
        return new_resource.url[0]
      else
        return new_resource.url
      end
    end
    def shortname
      return URI.parse.host.gsub(/^www\./, '').slice[0, 6]
    end
    def site_alias
      return "#{shortname}.#{new_resource.instance}"
    end
    def server_name
      if new_resource.url.is_a?
        s.array.new()
        new_resource.url.each {|u| s[] = u}
        return s.join(' ')
      else
        return new_resource.url.URI.parse.host
      end
    end
    def is_ssl
      if URI.parse.scheme == "https"
        return true
      else
        return false
      end
    end
    
    action :create do
      #todo: create file system
      
      directory '/etc/nginx/sites-enabled' do
        owner 'root'
        group 'root'
        mode 0755
        action :create
      end

      directory '/etc/drush' do
        owner 'root'
        group 'root'
        mode 0755
        action :create
      end

      #application directory
      directory "/srv/www/#{site_alias}" do
        owner 'sites'
        group 'sites'
        mode '0755'
        recursive TRUE
        action :create
      end

      #public files
      directory "/srv/www/#{site_alias}/#{public_files}" do
        owner node['nginx']['user']
        group node['nginx']['user']
        mode '0755'
        action :create
      end
      #private files
      directory "/srv/www/#{site_alias}/#{private_files}" do
        owner node['nginx']['user']
        group node['nginx']['user']
        mode '0755'
        action :create
      end

      ## create vhost file
      template "/etc/nginx/sites-enabled/#{site_alias}.conf" do
        source 'vhost.erb'
        owner 'root'
        group 'root'
        mode '0644'
        variables(
          is_ssl: is_ssl,
          url: server_name,
          path: new_resource.path,
          passwd: new_resource.passwd,
          is_ssl: is_ssl,
          private_dir: new_resource.private_dir
        )
        action :create
      end
      #todo: create add ssl
      #todo: create database
      #todo: create drush alieas
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
    end
  end
  
end
