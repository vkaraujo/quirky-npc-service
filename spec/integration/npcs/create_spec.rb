require 'swagger_helper'

RSpec.describe 'NPCs API', openapi_spec: 'v1/swagger.yaml', type: :request do
  path '/npcs' do
    post 'Create a new NPC' do
      tags 'NPC Management'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :npc, in: :body, schema: {
        type: :object,
        properties: {
          npc: {
            type: :object,
            properties: {
              name: { type: :string, example: 'Snorgus the Flatulent' },
              job: { type: :string, example: 'Goblin Negotiator' },
              quirk: { type: :string, example: 'Believes they are a potato' },
              mood: { type: :string, example: 'Dramatically bored' },
              species: {
                type: :string,
                enum: NpcAttributes.species
              },
              alignment: {
                type: :string,
                enum: NpcAttributes.alignments
              }
            },
            required: %w[name job quirk mood species alignment]
          }
        }
      }

      response '201', 'NPC created' do
        example 'application/json', :npc_response, {
          id: 42,
          name: "Snorgus the Flatulent",
          job: "Goblin Negotiator",
          quirk: "Believes they are a potato",
          mood: "Dramatically bored",
          species: "Goblin",
          alignment: "Chaotic Neutral",
          greeting: "Greetings, I am Snorgus the Flatulent, your humble Goblin Negotiator!"
        }

        let(:npc) do
          {
            npc: {
              name: "Snorgus the Flatulent",
              job: "Goblin Negotiator",
              quirk: "Believes they are a potato",
              mood: "Dramatically bored",
              species: "Goblin",
              alignment: "Chaotic Neutral"
            }
          }
        end

        run_test!
      end
    end
  end
end
