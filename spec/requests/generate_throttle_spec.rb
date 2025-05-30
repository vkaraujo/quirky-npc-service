# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'NPC generation rate limiting', type: :request do
  it 'blocks excessive POSTs to /npcs/generate' do
    limit = 5
    headers = { 'REMOTE_ADDR' => '1.2.3.4' }

    limit.times do
      post '/npcs/generate', headers: headers
      expect(response).to have_http_status(:ok).or have_http_status(:created)
    end

    post '/npcs/generate', headers: headers
    expect(response).to have_http_status(:too_many_requests)
    expect(JSON.parse(response.body)).to include('error' => 'Too Many Requests')
  end
end
