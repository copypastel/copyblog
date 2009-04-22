class AttractionsController < ApplicationController
  # GET /attractions
  # GET /attractions.xml
  def index
    @attractions = Attraction.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @attractions }
    end
  end

  # GET /attractions/1
  # GET /attractions/1.xml
  def show
    @attraction = Attraction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @attraction }
    end
  end

end
