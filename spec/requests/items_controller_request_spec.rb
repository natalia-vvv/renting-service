# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ItemsControllers', type: :request do
  before do
    create_list(:item, 5)
  end

  describe 'GET /items' do
    before do
      get '/items'
    end

    context 'when request successful' do
      it 'returns http success' do
        expect(response).to be_success
      end

      it 'returns the right amount of items' do
        expect(json.length).to eq(Item.count)
      end
    end
  end

  describe 'GET /items/id' do
    context 'when request successful' do
      before do
        get '/items/1'
      end

      it 'returns http success' do
        expect(response).to be_success
      end

      it 'item contains expected attributes' do
        expect(json.keys).to match_array(%w[id name owner_id created_at
                                            updated_at category_id])
      end
    end

    context 'when requests non-exist data' do
      it 'returns http not found' do
        get '/items/6'
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /items' do
    context 'when item has all parameters' do
      before do
        post '/items', params: { item: { name: 'Item', owner_id: 1 } }
      end

      it 'returns http success' do
        expect(response).to be_success
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
  end

  describe 'PATCH /items/1' do
    context 'when item successfully edited' do
      before do
        patch '/items/1', params: { item: { name: 'Edited name' } }
      end

      it 'return http success' do
        expect(response).to be_success
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

  describe 'DELETE /items/id' do
    context 'when item successfully deleted' do
      before do
        delete '/items/1'
      end

      it 'returns http success' do
        expect(response).to be_success
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
end
