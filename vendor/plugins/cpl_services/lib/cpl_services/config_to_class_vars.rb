module CPL::Service::ConfigToClassVars
  def init(config)
    config.each_pair do |key,value|
      @subclass.class_eval do
        eval "
        @#{key} = '#{value}'
        def self.#{key}
          @#{key}
        end
        "
      end
    end
  end

  def self.extended(subclass)
    subclass.class_eval do
      @subclass = subclass
    end
  end
end
