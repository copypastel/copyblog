class Pleet < CPL::Tools::YPipes::Base
  pipe_uri_set(CPL::Service::Lessthan140.pipeurl)
  
  def self.all
    pleets = []
    CPL::Service::Lessthan140.users.each_pair do |user,services|
      paramaters = {:limit => 6}
      services.each { |s| paramaters[s] = user}

      super(paramaters) do |items|
        items.each do |item|
          author = item['author']
          msg    = item['msg']
          uri    = item['uri']
          time   = item['time']
          pleets.push(Pleet.new(author,msg,uri,time))
        end
      end
    end

    pleets.sort_by { |p| p.time }.reverse.first(6)
  end

  attr_reader   :author,:msg,:uri,:time
  def initialize(author, msg, uri, time)
    @author = author.downcase
    @msg = msg
    @uri = uri
    @time = Time.at(time.to_i)
  end
end
