class Flickr < CPL::Tools::YPipes::Base
  pipe_uri_set(CPL::Service::Flickr.pipeurl)
  
  def self.all
    u_ids = []
    flickrs = []
    CPL::Service::Flickr.users.each { |u| u_ids.push(CPL::Service::Flickr.username_to_id(u))}
    
    u_ids.each do |uid|
      super(:limit => 8, :user_id => uid) do |items|
        items.each do |item|
          flickrs.push(Flickr.new(item['url'],item['img_src'],item['alt'],item['time']))
        end
      end
    end
    
    flickrs.sort_by { |p| p.time }.reverse.first(8)
  end
  
  attr_reader   :url,:img_src,:alt,:time
  def initialize(url, img_src, alt, time)
    @url = url
    @img_src = img_src
    @alt = alt
    @time = time
  end
end