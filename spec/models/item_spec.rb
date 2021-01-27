require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'create item' do
    context 'has valid parameters' do
      it 'creates item' do
        item = create(:item)
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
    before(:context) do
      create_list(:item, 5)
    end

    context 'finds by name' do
      it 'returns items found by name' do
        expect(Item.find_by_name('My item')).to match_array(Item.where(name: 'My item'))
      end

      it 'returns items found by part of name' do
        expect(Item.find_by_name('item')).to match_array(Item.where('name LIKE ?', '%item%'))
      end
    end

    context 'finds by category name' do
      it 'returns items found by category name' do
        create(:category)
        create_list(:item, 3, :with_category)
        expect(Item.find_by_category('Sport')).to match_array(Category.find_by_name('Sport').items)
      end
    end
  end

end
