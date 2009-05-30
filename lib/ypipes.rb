module CPL; module Tools; end; end
module CPL::Tools::YPipes

  class Base
    def self.inherited(subclass)
      subclass.class_eval do
        def self.pipe_uri
          @pipe_uri
        end

        def self.pipe_uri=(uri)
          @pipe_uri = uri
        end
      end
    end
  end
end
