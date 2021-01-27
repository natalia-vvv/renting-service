require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    create(:user)
    create_list(:booking, 3)
  end

  describe 'create user' do
    context 'has valid parameters' do
      it 'creates user' do
        user = build(:user)
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
      create(:booking, client_id: 2)
      expect(User.first.booked_items).to match_array(Item.first(3))
    end
  end

  describe 'when owners of booked items requested' do
    it 'returns items\' owners' do
      expect(User.first.owners_of_booked_items).to match_array(User.offset(1))
    end
  end

end
