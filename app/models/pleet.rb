class Pleet
  def self.all
    config = CPL::Service::Lessthan140
    yPipeUri =config.pipeurl
    pleets = []
    config.users.each_pair do |user,services|
      query = yPipeUri+"&_render=json&limit=3&" + services.collect{ |s| "#{s}=#{user}"}.join("&")
      dat = JSON.parse(open(query).read)
      dat['value']['items'].each do |item|
        author = item['author']
        msg    = item['msg']
        uri    = item['uri']
        time   = item['time']
        pleets.push(Pleet.new(author,msg,uri,time))
      end
    end

    pleets.sort_by { |p| p.time }.reverse
  end

  attr_reader   :author,:msg,:uri,:time
  def initialize(author, msg, uri, time)
    @author = author.downcase
    @msg = msg
    @uri = uri
    @time = Time.at(time.to_i)
  end
end
