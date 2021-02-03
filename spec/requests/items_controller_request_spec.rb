# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemsController, type: :request do
  before do
    create_list(:item, 5)
  end

  describe 'GET /items' do
    before do

      get '/items', as: :json, headers: { Authorization: 'Bearer' }
    end

    context 'when request successful' do
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns the right amount of items' do
        expect(json.length).to eq(5)
      end
    end
  end

  describe 'GET /items/id', :realistic_error_responses do
    context 'when request successful' do
      before do
        get '/items/1'
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'item contains expected attributes' do
        expect(json.keys).to match_array(%w[id name owner_id created_at
                                            updated_at category_id daily_price])
      end
    end

    context 'when requests non-exist data' do
      it 'returns http not found' do
        get '/items/6'
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /items', :realistic_error_responses do
    context 'when item has all parameters' do
      before do
        post '/items', params: { item: { name: 'Item', owner_id: 1, daily_price: 20 } }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'increases amount of items' do
        get '/items'
        expect(json.length).to eq(6)
      end
    end

    context 'when item has not all parameters' do
      it 'returns http bad request' do
        post '/items', params: { item: {} }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when item has options' do
      let!(:small) { create(:option, value: 'Small') }
      let!(:red) { create(:option) }

      it 'creates item with options' do
        params = {
          item: {
            name: 'Item',
            owner_id: 1,
            item_options: [red.id, small.id]
          }
        }
        post '/items', params: params
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'PATCH /items/1', :realistic_error_responses do
    context 'when item successfully edited' do
      before do
        patch '/items/1', params: { item: { name: 'Edited name' } }
      end

      it 'return http success' do
        expect(response).to have_http_status(:success)
      end

      it 'modified an item' do
        get '/items/1'
        expect(json['name']).to eq('Edited name')
      end
    end

    context 'when request has bad parameters' do
      before do
        patch '/items/1', params: { item: {} }
      end

      it 'returns bad request' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'DELETE /items/id', :realistic_error_responses do
    context 'when item successfully deleted' do
      before do
        delete '/items/1'
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'decreases amount of items' do
        get '/items'
        expect(json.length).to eq(4)
      end
    end

    context 'when delete non-exist item' do
      it 'returns http not found' do
        delete '/items/6'
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '.my_items' do
    before do
      r = Rodauth::Rails.rodauth
      token = JWT.encode({ account_id: nazar.id }, r.jwt_secret, r.jwt_algorithm)
      get '/my_items', params: {}, as: :json, headers: { Authorization: "Bearer #{token}" }
    end

    let!(:nazar) { create(:account, user: create(:user, first_name: 'Nazar')) }
    let!(:nazar_item) { create(:item, name: "Nazar's item", owner: nazar.user) }
    let!(:other_item) { create(:item) }
    
    it 'returns http success' do
      p nazar_item
      expect(response).to have_http_status(:success)
    end

    it "returns current user's items" do
      p response.body
      expect(json).to match_array([nazar_item])
    end
  end

  describe '.by_name' do
    before do
      account = create(:account, user: create(:user, first_name: 'Nazar'))

      # post "/create-account", params: { login: "foo@example.com", password: "secret", confirm_password: "secret" }, as: :json
      # p token = response.headers["Authorization"]

      r = Rodauth::Rails.rodauth

      # p jwt_payload = JWT.decode(token, r.jwt_secret, true, r.send(:_jwt_decode_opts).merge(:algorithm=>r.jwt_algorithm))[0]
      token = JWT.encode({ account_id: account.id }, r.jwt_secret, r.jwt_algorithm)

      get '/items', params: { name: 'item' }, as: :json, headers: { Authorization: "Bearer #{token}" }
    end

    it 'has success http response' do
      expect(response).to have_http_status(:success)
    end

    it 'returns filtered items by name' do
      expect(json).to match_array(Item.by_name('item').as_json)
    end
  end

  describe '.by_category' do
    let!(:sport) { create(:category) }
    let!(:sport_item) { create(:item, category: sport) }
    before do
      get '/items', params: { category: sport.id }
    end

    it 'has success http response' do
      expect(response).to have_http_status(:success)
    end

    it 'returns filtered items by category' do
      expect(json).to match_array(Item.by_category(sport.id).as_json)
    end
  end

  describe '.by_option' do
    let!(:red) { create(:item_option) }
    let!(:small) do
      create(:item_option) do
        create(:option, value: 'Small')
      end
    end
    let!(:one_option_params) { { options: [red.option_id] } }
    let!(:two_options_params) { { options: [red.option_id, small.option_id] } }

    it 'has success http response' do
      get '/items', params: one_option_params
      expect(response).to have_http_status(:success)
    end

    it 'returns filtered items by option' do
      get '/items', params: one_option_params
      expect(json).to match_array(Item.by_option([red.option_id]).as_json)
    end

    it 'returns filtered items by a few options' do
      get '/items', params: two_options_params
      expect(json).to match_array(Item.by_option([red.option_id, small.option_id]).as_json)
    end
  end

  describe '.by_price_range' do
    before do
      params = {
        min_price: 0,
        max_price: 65,
        days: 3
      }
      get '/items', params: params
    end

    it 'has success http response' do
      expect(response).to have_http_status(:success)
    end

    it 'returns filtered items by price range' do
      expect(json).to match_array(Item.by_price_range(0..65, 3).as_json)
    end
  end

  describe '.by_non_booked_date' do
    let!(:from_date) { Time.new(2020, 1, 1) }
    let!(:booking) do
      create(:booking, start_date: from_date, end_date: from_date + 10.days)
    end

    before do
      params = {
        start_date: from_date,
        end_date: from_date + 10.days
      }
      get '/items', params: params
    end

    it 'has success http response' do
      expect(response).to have_http_status(:success)
    end

    it 'returns filtered items by price range' do
      expect(json).to match_array(Item.by_non_booked_date(from_date, from_date + 10.days).as_json)
    end
  end

  describe 'filtering with a few criteria' do
    let!(:sport) { create(:category) }
    let!(:sport_item) { create(:item, category: sport, name: 'Ball') }
    let!(:red_sport_cheap_item) do
      create(:item, category: sport, daily_price: 1)
    end

    let!(:red_item_option) do
      create(:item_option, item: red_sport_cheap_item, option: red)
    end

    let!(:red) { create(:option) }
    let!(:from_date) { Time.new(2020, 1, 1) }
    let!(:booking) do
      create(:booking, start_date: from_date, end_date: from_date + 10.days)
    end

    it 'filters by name and category' do
      get '/items', params: { name: 'Ball', category: sport.id }
      expect(json).to match_array(Item.by_name('Ball')
                                      .by_category(sport.id).as_json)
    end

    it 'filters by options, price range and non-booked dates' do
      params = {
        options: [red.id],
        min_price: 0,
        max_price: 5,
        days: 5,
        start_date: from_date,
        end_date: from_date + 10.days
      }
      get '/items', params: params
      items = Item.by_non_booked_date(from_date, from_date + 10.days)
                  .by_option([red.id])
                  .by_price_range(0..5, 5)

      expect(json).to match_array(items.as_json)
    end
  end
end
