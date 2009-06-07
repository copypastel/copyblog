module CPL::Service::Flickr
  extend CPL::Service::ConfigToClassVars
  
  def self.username_to_id(username)
    # You want to get a new agent only once. Class variable?
    @agent ||= WWW::Mechanize.new

    @agent.get('http://idgettr.com/') do |page|
      result = page.form_with( :action => 'http://idgettr.com') do |form|
        form.photostream = 'http://www.flickr.com/photos/' + username
      end.submit
      result = Hpricot(result.body)
      return (result/'#results'/'p').inner_html.sub('<strong>ID:</strong> ', '')
    end    
  end
end
