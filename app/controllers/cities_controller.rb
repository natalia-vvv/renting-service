class CitiesController < ApplicationController
  def index
    @items = Item.all
    render json: @items
  end

  # def fetch_items
  #   @city = City.find(params[:id])
  #   City.get_items
  # end

  def show
    @city = City.find(params[:id])
    render json: @city
  end
end
