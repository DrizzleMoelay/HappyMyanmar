class PlacesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :move_to_index, except: [:index, :show]
  def index
    @places = Place.all
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    if @place.save
      redirect_to root_path 
    else
      render :new
    end
  end

  def show
    @place = Place.find(params[:id])
    @comment = Comment.new
    @comments = @place.comments.includes(:user)
  end

  def edit
    @place = Place.find(params[:id])
    if @place.user_id != current_user.id
      redirect_to root_path
    end
  end

  def update
    @place = Place.find(params[:id])
    @place.update_attributes(place_params)
     if @place.save
      redirect_to place_path 
    else
      @place.attributes = (place_params)
      render :edit
    end
  end

  def destroy
    place = Place.find(params[:id])
    place.destroy
    redirect_to root_path
  end


  private

  def place_params
    params.require(:place).permit(:title, :concept, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
