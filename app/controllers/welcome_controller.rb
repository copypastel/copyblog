class WelcomeController < ApplicationController
  def index
    @tweets = []
    @latest_attraction = Attraction.first || Attraction.create
    @attractions = Attraction.all
    @github_projects = []
    @flickr_images = []
  end
end
