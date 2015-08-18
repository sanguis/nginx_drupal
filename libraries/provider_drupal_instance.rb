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
      return  URI.parse.host.primary_url.gsub(/^www\./, '').slice[0, 6]
    end
    def alias
      return "#{shortname}.#{new_resource.instance}"
    end
    
    action :create do
      #todo: create file system
      #todo: create vhost file
      #todo: create add ssl
      #todo: create database
      #todo: create drush alieas
    end
    action :delete do
      #todo: delete file system
      #todo:delete vhost file
      #todo: delete database
      #todo: delete drush alieas
    end
  end
  
end
