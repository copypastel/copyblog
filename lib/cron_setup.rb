libdir = File.expand_path(File.dirname(__FILE__))
$:.ushift libdir unless $:.include? libdir

module CPL
  module Setup
    def run
      config_file = File.dirname(__FILE__) + "/../config/copyblog.yml"
      config = YAML.load_file(File.expand_path(config_file))

      cronID = "#{config['blogname']}-"
      config['services'].each do |service|
        require "update_#{service}"
        mod = eval(service.capatalize) #module for service
        id = cronID+service
        CronEdit::Crontab.Add(id,mod::CronDefinition(config['services'][service]))
      end
    end
  end
end

app = App.new ARGV, options
app.extend CPL::Setup
app.run
