class GithubProject < ActiveRecord::Base
  def active?
    (Time.now - weeks(2)) < self.last_updated
  end
  
private
  def weeks(weeks)
    60*60*24*7*weeks
  end
end
