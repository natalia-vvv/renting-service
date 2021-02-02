# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :set_item, only: %i[show update destroy]
  before_action :apply_filters, only: :index
  before_action :authenticate
  after_action { pagy_headers_merge(@pagy) if @pagy }

  def index
    @pagy, @items = pagy(@items, items: 10)
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
    params.require(:item).permit(:name, :owner_id, :daily_price,
                                 :category_id, item_options: [:option_id])
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_parameters
    @name = params[:name]
    @category = params[:category]
    @options = params.permit(options: [])
    @price_range = int_values(params.permit(:min_price, :max_price, :days))
    @non_booked = params.permit(:start_date, :end_date)
  end

  def apply_filters
    set_parameters
    @items = Item.all
    @items = items_merge(@items, Item.by_name(@name)) if @name
    @items = items_merge(@items, Item.by_category(Integer(@category))) if @category
    @items = items_merge(@items, Item.by_option(@options[:options])) unless @options.empty?
    unless @price_range.empty?
      range = @price_range[:min_price]..@price_range[:max_price]
      @items = items_merge(@items, Item.by_price_range(range,
                                                       @price_range[:days]))
    end
    unless @non_booked.empty?
      @items = items_merge(@items, Item.by_non_booked_date(@non_booked[:start_date], @non_booked[:end_date]))
    end
  end

  def int_values(hash)
    hash.each { |key, value| hash[key] = Integer(value) }
  end

  def items_merge(items, filtered_items)
    items == Item.all ? filtered_items : items & filtered_items
  end
end
