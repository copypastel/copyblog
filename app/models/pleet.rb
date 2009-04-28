class Pleet < ActiveRecord::Base
  
  def self.url_for(pleet)
    if pleet.plurk?
      "http://plurk.com/#{pleet.author}"
    else
      "http://twitter.com/#{pleet.author}"
    end
  end
  
  def plurk?
    self.origin == "plurk"
  end
  
  def twitter?
    self.origin == "twitter"
  end
end
