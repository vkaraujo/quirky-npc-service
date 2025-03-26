require 'swagger_helper'

RSpec.describe 'NPCs API', openapi_spec: 'v1/swagger.yaml', type: :request do
  path '/npcs/{id}' do
    get 'Retrieve a specific NPC by ID' do
      tags 'NPC Management'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'NPC found' do
        let(:id) { create(:npc).id }
        run_test!
      end

      response '404', 'NPC not found' do
        let(:id) { 99999 }
        run_test!
      end
    end
  end
end
