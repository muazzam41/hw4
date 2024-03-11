class PlacesController < ApplicationController

  def index
    @places = Place.all
    @current_user = User.find_by({ "id" => session["user_id"] })
  end

  def show
    @place = Place.find_by({ "id" => params["id"] })
    if @current_user != nil
     @entries = Entry.where({ "place_id" => @place["id"], "user_id" => @current_user["id"]})
    else
      flash["notice"] = "Please login before viewing entries"
      redirect_to "/login"
    end
  end

  def new
  end

  def create
    @place = Place.new
    @place["name"] = params["name"]
    @place.save
    redirect_to "/places"
  end

end
