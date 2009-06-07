module CPL; module Tools; end; end
module CPL::Tools::YPipes

  class Base
    def self.inherited(subclass)
      subclass.class_eval do
        def self.pipe_uri
          @pipe_uri
        end

        def self.pipe_uri_set(uri)
          @pipe_uri = uri
        end
      end
    end
    
    def self.call_pipe(paramaters = {}, &block)
      query = self.pipe_uri+"&_render=json&" + paramaters.collect{|key,value| "#{key}=#{value}"}.join('&')
      json = JSON.parse(open(query).read())
      yield(json) if block_given?
      json
    end
    
    def self.all(paramaters = {}, &block)
      json = self.call_pipe(paramaters)
      items = json['value']['items']
      yield(items) if block_given?
    end
  end
end
