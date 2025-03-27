require 'rails_helper'

RSpec.describe 'ApplicationController error handling', type: :request do
  describe 'GET /npcs/:id with nonexistent ID' do
    it 'returns 404 with a meaningful message' do
      get '/npcs/999999'

      expect(response).to have_http_status(:not_found)
      json = JSON.parse(response.body)

      expect(json).to include(
        'error' => 'Not Found'
      )
      expect(json['message']).to match(/Couldn't find Npc/)
    end
  end

  describe 'POST /npcs with missing params' do
    it 'returns 400 when npc param is missing' do
      post '/npcs', params: {} # Missing required npc param

      expect(response).to have_http_status(:bad_request)
      json = JSON.parse(response.body)

      expect(json['error']).to eq('Bad Request')
      expect(json['message']).to match(/param is missing or the value is empty/)
    end
  end

  describe 'GET /npcs with invalid enum filter' do
    it 'returns 422 for invalid enum via simulated error' do
      allow(Npc).to receive(:by_alignment).and_raise(ArgumentError, 'invalid value for alignment')
    
      get '/npcs', params: { alignment: 'Invalid' }
    
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
