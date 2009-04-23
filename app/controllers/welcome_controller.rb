class WelcomeController < ApplicationController
  def index
    @tweets = []
    @attractions = Attraction.all
    @latest_attraction = @attractions.delete_at(0)
    @github_projects = GithubProject.all
    @flickr_images = []
  end
end
