module CPL::Service::ConfigToClassVars
  def init(config)
    config.each_pair do |key,value|
      @subclass.class_eval do
        propdef = "
          def self.#{key}
            @#{key}
          end
        "
        eval propdef
        self.instance_variable_set("@#{key}",value)
      end
    end
  end

  def self.extended(subclass)
    subclass.class_eval do
      @subclass = subclass
    end
  end
end
