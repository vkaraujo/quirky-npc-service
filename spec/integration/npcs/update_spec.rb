# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'NPCs API', openapi_spec: 'v1/swagger.yaml', type: :request do
  path '/npcs/{id}' do
    patch 'Update an existing NPC' do
      tags 'NPC Management'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :npc, in: :body, schema: {
        type: :object,
        properties: {
          npc: {
            type: :object,
            properties: {
              name: { type: :string, example: 'Tilda Fizzlepot' },
              job: { type: :string, example: 'Potion Tester' },
              quirk: { type: :string, example: 'Only speaks in rhymes' },
              mood: { type: :string, example: 'Melancholic but hopeful' },
              species: {
                type: :string,
                enum: NpcAttributes.species,
                example: 'Halfling'
              },
              alignment: {
                type: :string,
                enum: NpcAttributes.alignments,
                example: 'Lawful Good'
              }
            }
          }
        }
      }

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
    end
  end
end
