# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  let!(:item) { create(:item) }
  let!(:other_item) { create(:item, name: 'Other item') }

  describe 'create item' do
    context 'has valid parameters' do
      it 'creates item' do
        expect(item).to be_valid
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
    let!(:category) { create(:category) }
    let!(:other_category) { create(:category, name: 'Category 2') }
    let!(:item_with_category) { create(:item, category: category) }
    let!(:items_with_searched_name) { [item, item_with_category] }
    let!(:items_with_part_name) { [item, item_with_category, other_item] }

    context 'finds by name' do
      it 'returns items found by name' do
        expect(Item.by_name('My item')).to match_array(items_with_searched_name)
      end

      it 'returns items found by part of name' do
        expect(Item.by_name('item')).to match_array(items_with_part_name)
      end
    end

    context 'finds by category' do
      it 'returns items found by category' do
        expect(Item.by_category(category)).to match_array(item_with_category)
      end
    end

    context 'search by options' do
      let!(:color_option) { create(:option) }
      let!(:size_option) { create(:option, value: 'Small') }
      let!(:option1_for_item1) { create(:item_option, item: item, option: color_option) }
      let!(:option2_for_item1) { create(:item_option, item: item, option: size_option) }
      let!(:option_for_item2) { create(:item_option, item: other_item, option: color_option) }

      it 'finds items by one option' do
        expect(Item.by_option(color_option.id)).to match_array([item, other_item])
      end

      it 'finds items by two options' do
        expect(Item.by_option(color_option.id, size_option.id)).to match_array([item])
      end
    end
  end

end
