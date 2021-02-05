# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :set_item, only: %i[show update destroy]
  before_action :apply_filters, only: :index
  before_action :authenticate
  after_action { pagy_headers_merge(@pagy) if @pagy }

  def index
    @pagy, @items = pagy(@items, items: 10)
    render json: @items
  end

  def my_items
    @user_id = current_user.id
    apply_filters
    render json: @items
  end

  def users_items
    @user_id = params[:user_id]
    apply_filters
    render json: @items
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
    params.require(:item).permit(:name, :owner_id, :daily_price,
                                 :category_id, item_options: [:option_id])
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def apply_filters
    @items = @user_id ? all_users_items : Item.all
    item_filter = ItemFilter.new
    @items = item_filter.call(params, @items)
  end

  def all_users_items
    Item.where(owner_id: @user_id)
  end
end
