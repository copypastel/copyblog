class GithubProject < CPL::Tools::YPipes::Base
  pipe_uri_set(CPL::Service::Github.pipeurl)
 
  def self.all
    projects = []
    super(:username => CPL::Service::Github.username) do |items|
      items.each do |item|
        projects.push(GithubProject.new(item['name'],item['url'],item['time']))
      end
    end
    projects.sort_by {|p| p.time }.reverse
  end
  
  def active?
    (Time.now - weeks(1)) < self.time
  end
  
  attr_reader   :name,:url,:time
  def initialize(name, url, time)
    @name = name
    @url  = url
    @time = Time.parse(time)
  end
  
private
  def weeks(weeks)
    60*60*24*7*weeks
  end
end
