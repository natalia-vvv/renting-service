class ItemsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :get_item, only: %i[show update destroy]

  def index
    @items = Item.all
    render json: @items, status: 200
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      render json: @item, status: 200
    else
      render json: { error: 'Unable to create item' }, status: 400
    end
  end

  def show
    render json: @item, status: 200
  end

  def update
    edited_params = item_params
    if @item && edited_params
      @item.update(edited_params)
      render json: { message: 'Item successfully updated.' }, status: 200
    else
      render json: { error: 'Unable to update item' }, status: 400
    end
  end

  def destroy
    if @item
      @item.destroy
      render json: { message: 'Item successfully deleted.' }, status: 200
    else
      render json: { error: 'Unable to delete item' }, status: 400
    end
  end

  private

  def item_params
    params.require(:item).permit( :name, :owner_id)
  rescue
    nil
  end

  def get_item
    @item = Item.find(params[:id])
  rescue
    render json: { error: "Couldn't find such item" }, status: 404
  end
end
