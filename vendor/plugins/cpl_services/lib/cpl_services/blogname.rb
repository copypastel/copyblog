module CPL::Service::Blogname
  def self.init(config)
    @blogname = config
    def self.name
      @blogname
    end
  end
end
