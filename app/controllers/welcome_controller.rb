class WelcomeController < ApplicationController
  def index
    @pleets = Pleet.all
    @attractions = Attraction.all.reverse
    @latest_attraction = @attractions.delete_at(0)
    @github_projects = GithubProject.all
    @flickr_images = Flickr.all
  end
end
