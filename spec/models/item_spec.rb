# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '.create' do
    context 'has valid parameters' do
      it 'creates item' do
        expect(create(:item)).to be_valid
      end
    end

    context 'has invalid parameters' do
      it 'does not create item without name' do
        item = build(:item, name: nil)
        expect(item).not_to be_valid
      end

      it 'does not create item without owner' do
        item = build(:item, owner_id: nil)
        expect(item).not_to be_valid
      end
    end
  end

  describe 'search by attributes' do
    let!(:item) { create(:item) }
    let!(:other_item) { create(:item, name: 'Other item') }

    let!(:sport) { create(:category, name: 'Sport') }
    let!(:beauty) { create(:category, name: 'Beauty') }
    let!(:sport_item) { create(:item, category: sport) }

    context 'finds by name' do
      it 'returns items found by name' do
        expect(Item.by_name('My item')).to match_array([item, sport_item])
      end

      it 'returns items found by part of name' do
        expect(Item.by_name('item')).to match_array([item, sport_item,
                                                     other_item])
      end
    end

    context 'finds by category' do
      it 'returns items found by category' do
        expect(Item.by_category(sport)).to match_array(sport_item)
      end
    end

    context 'search by options' do
      let!(:pink) { create(:option, value: 'Pink') }
      let!(:small) { create(:option, value: 'Small') }

      let!(:small_pink_item) do
        create(:item) do |item|
          create(:item_option, item: item, option: small)
          create(:item_option, item: item, option: pink)
        end
      end

      let!(:small_item) do
        create(:item) do |item|
          create(:item_option, item: item, option: small)
        end
      end

      it 'finds items by one option' do
        expect(Item.by_option([small.id])).to match_array([small_item,
                                                           small_pink_item])
      end

      it 'finds items by two options' do
        expect(Item.by_option([small.id,
                               pink.id])).to match_array([small_pink_item])
      end
    end
  end

  describe '.by_price_range' do
    let(:cheap_item) { create(:item, daily_price: 5) }
    let(:expensive_item) { create(:item, daily_price: 50) }

    it 'filters items by price_range' do
      expect(Item.by_price_range(10..30, 2)).to match_array([cheap_item])
      expect(Item.by_price_range(10..300, 5)).to match_array([cheap_item, expensive_item])
    end
  end

  describe '.by_non_booked_date' do
    subject(:query) { described_class.by_non_booked_date(Date.yesterday, Date.tomorrow) }

    let!(:from_date) { Date.new(2020, 1, 1) }
    let!(:free_item) { create(:item, name: 'Free item') }

    let!(:booked_item_feb) do
      create(:item, name: 'Item feb') do |i|
        create(:booking, item: i, start_date: Date.new(2020, 1, 1), end_date: Date.new(2020, 1, 3))
        create(:booking, item: i, start_date: Date.today, end_date: Date.today)
      end
    end

    it 'should returns free items' do
      expect(query.pluck(:id)).to contain_exactly(free_item.id)
    end

    context 'item is booked on full date range' do
      let!(:booked_item_jan) do
        create(:item) do |item|
          create(:booking, start_date: from_date, end_date: from_date + 10.days, item: item)
        end
      end
      let!(:lately_booked_item) do
        create(:item) do |item|
          create(:booking, start_date: from_date + 11.days, end_date: from_date + 20.days, item: item)
        end
      end

      it 'returns only free items' do
        expect(Item.by_non_booked_date(from_date, from_date + 10.days)).to match_array([free_item, lately_booked_item])
      end
    end

    context 'item is booked on one day from range' do
      let!(:other_booked_item) do
        create(:item, name: 'Booked item') do |item|
          create(:booking, start_date: from_date - 1.day, end_date: from_date + 1.day, item: item)
        end
      end

      it 'returns only free items' do
        p Item.all
        expect(Item.by_non_booked_date(from_date, from_date + 10.days)).to match_array([free_item])
      end
    end
  end
end
