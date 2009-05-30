# CplServices
libdir = File.expand_path(File.dirname(__FILE__))
$:.ushift libdir unless $:.include? libdir

module CPL; module Service; end; end
require 'cpl_services/config_to_class_vars'

SERVICE_CONFIG = "#{RAILS_ROOT}/config/copyblog.yml"
config = YAML.load_file(File.expand_path(SERVICE_CONFIG))

config.each_pair do |service,config|
  require "cpl_services/#{service}"
  service = "CPL::Service::#{service.capitalize}".constantize
  service.init(config)
end
