require 'swagger_helper'

RSpec.describe 'NPCs API', openapi_spec: 'v1/swagger.yaml', type: :request do
  path '/npcs/generate' do
    post 'Generate a random, ephemeral NPC' do
      tags 'Generation'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :npc, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'Brum the Quiet' },
          job: { type: :string, example: 'Wand Polisher' },
          quirk: { type: :string, example: 'Collects spoons' },
          mood: { type: :string, example: 'Mysteriously excited' },
          species: {
            type: :string,
            enum: NpcAttributes.species,
            example: 'Elf'
          },
          alignment: {
            type: :string,
            enum: NpcAttributes.alignments,
            example: 'True Neutral'
          }
        }
      }

      response '200', 'NPC generated' do
        let(:npc) { {} }
        run_test!
      end
    end
  end
end
