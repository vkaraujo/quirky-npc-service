# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Npcs", type: :request do
  describe 'GET /npcs with filters' do
    let!(:npc1) { create(:npc, species: 'Elf', alignment: 'Chaotic Evil', mood: 'grumpy', job: 'bard', quirk: 'snorts when laughing') }
    let!(:npc2) { create(:npc, species: 'Human', alignment: 'Lawful Good', mood: 'joyful', job: 'wizard', quirk: 'talks in rhyme') }

    it 'filters by mood' do
      get '/npcs', params: { mood: 'grumpy' }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['npcs'].map { |n| n['id'] }).to contain_exactly(npc1.id)
    end

    it 'filters by job and quirk' do
      get '/npcs', params: { job: 'wizard', quirk: 'talks in rhyme' }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['npcs'].map { |n| n['id'] }).to contain_exactly(npc2.id)
    end
  end
end
