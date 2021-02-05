class ItemFilter
  def call(params, items)
    items = filter_by_name(params, items)
    items = filter_by_options(params, items)
    items = filter_by_category(params, items)
    items = filter_by_price_range(params, items)
    filter_by_dates_range(params, items)
  end

  def filter_by_dates_range(params, items)
    non_booked = params.permit(:start_date, :end_date)
    unless non_booked.nil?
      items = items.by_non_booked_date(non_booked[:start_date],
                                       non_booked[:end_date])
    end
    items
  end

  def filter_by_price_range(params, items)
    price_range = int_values(params.permit(:min_price, :max_price, :days))
    unless price_range.nil?
      range = price_range[:min_price]..price_range[:max_price]
      items = items.by_price_range(range, price_range[:days])
    end
    items
  end

  def filter_by_options(params, items)
    params[:options].nil? ? items : items.by_option(params[:options])
  end

  def filter_by_category(params, items)
    params[:category].nil? ? items : items.by_category(Integer(params[:category]))
  end

  def filter_by_name(params, items)
    params[:name].nil? ? items : items.by_name(params[:name])
  end

  def int_values(hash)
    hash.each { |key, value| hash[key] = Integer(value) }
  end
end
