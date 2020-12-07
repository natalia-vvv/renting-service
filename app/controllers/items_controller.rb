class ItemsController < ApplicationController
  before_action :get_item, only: [:show, :update, :destroy]

  def index
    @items = Item.all
    render json: @items
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to @item
      render json: @item
    else
      render error: { error: 'Unable to create item' }, status: 400
    end
  end

  def show
    render json: @item
  end

  def update
    if @item
      @item.update(item_params)
      render json: { message: 'Item successfully updated.'}, status: 200
    else
      render error: { error: 'Unable to create item' }, status: 400
    end
  end

  def destroy
    if @item
      @item.destroy
      render json: { message: 'Item successfully deleted.'}, status: 200
    else
      render error: { error: 'Unable to delete item' }, status: 400
    end
  end

  private
    def item_params
      params.require(:item).permit(:name)
    end

    def get_item
      @item = Item.find(params[:id])
    end
  end


