# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'NPCs API', openapi_spec: 'v1/swagger.yaml', type: :request do
  path '/npcs/{id}' do
    patch 'Update an existing NPC' do
      tags 'NPC Management'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer
      parameter name: :npc, in: :body, schema: { '$ref': '#/components/schemas/NpcUpdateRequest' }

      response '200', 'NPC updated' do
        let(:id) { create(:npc).id }
        let(:npc) do
          {
            npc: {
              mood: 'suspiciously friendly',
              quirk: 'believes they are a potato'
            }
          }
        end

        run_test!
      end

      response '404', 'NPC not found' do
        let(:id) { 99_999 }
        let(:npc) { { npc: { mood: 'dramatically bored' } } }

        run_test!
      end

      response '422', 'Validation error' do
        let(:id) { create(:npc).id }
        let(:npc) do
          {
            npc: {
              name: '',
              mood: 'curious',
              species: 'Goblin'
            }
          }
        end

        schema '$ref' => '#/components/schemas/ErrorResponse'

        example 'application/json', :validation_error, {
          error: 'Unprocessable Entity',
          message: "Name can't be blank"
        }

        run_test!
      end
    end
  end
end
