require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }
  let!(:booked_item) { create(:item) }
  let!(:other_item) { create(:item) }
  let!(:booking) { create(:booking, client: user, item: booked_item) }
  let!(:other_booking) { create(:booking, client: create(:user), item: other_item) }

  describe 'create user' do
    context 'has valid parameters' do
      it 'creates user' do
        expect(user).to be_valid
      end
    end

    context 'has invalid parameters' do
      it 'does not create user without first name' do
        user = build(:user, first_name: nil)
        expect(user).not_to be_valid
      end

      it 'does not create user without last name' do
        user = build(:user, last_name: nil)
        expect(user).not_to be_valid
      end
    end
  end

  describe 'when all booked items requested' do
    it 'returns booked items' do
      expect(user.booked_items).to match_array(booked_item)
    end
  end

  describe 'when owners of booked items requested' do
    it 'returns items\' owners' do
      expect(user.owners_of_booked_items).to match_array(booked_item.owner)
    end
  end

end
