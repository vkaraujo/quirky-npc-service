# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'NPCs API', openapi_spec: 'v1/swagger.yaml', type: :request do
  path '/npcs' do
    post 'Create a new NPC' do
      description 'Creates and saves a new NPC with custom attributes.'
      tags 'NPC Management'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :npc, in: :body, schema: { '$ref': '#/components/schemas/NpcRequest' }

      response '201', 'NPC created' do
        schema '$ref': '#/components/schemas/NpcResponse'

        example 'application/json', :npc_response, {
          id: 42,
          name: 'Snorgus the Flatulent',
          job: 'Goblin Negotiator',
          quirk: 'Believes they are a potato',
          mood: 'Dramatically bored',
          species: 'Goblin',
          alignment: 'Chaotic Neutral',
          greeting: 'Greetings, I am Snorgus the Flatulent, your humble Goblin Negotiator!'
        }

        let(:npc) do
          {
            npc: {
              name: 'Snorgus the Flatulent',
              job: 'Goblin Negotiator',
              quirk: 'Believes they are a potato',
              mood: 'Dramatically bored',
              species: 'Goblin',
              alignment: 'Chaotic Neutral'
            }
          }
        end

        run_test!
      end

      response '400', 'Missing npc param' do
        schema '$ref' => '#/components/schemas/BadRequestResponse'

        example 'application/json', :bad_request, {
          error: 'Bad Request',
          message: 'param is missing or the value is empty: npc'
        }

        let(:npc) { nil }
        run_test!
      end

      response '422', 'Validation error' do
        schema '$ref' => '#/components/schemas/ErrorResponse'

        example 'application/json', :validation_error, {
          error: 'Unprocessable Entity',
          message: "Name can't be blank"
        }

        let(:npc) do
          {
            npc: {
              name: '',
              job: 'Goblin Negotiator',
              quirk: 'Believes they are a potato',
              mood: 'Dramatically bored',
              species: 'Goblin',
              alignment: 'Chaotic Neutral'
            }
          }
        end

        run_test!
      end

      response '422', 'Validation error - duplicate name' do
        let!(:existing_npc) { create(:npc, name: 'Duplicate') }

        let(:npc) do
          {
            npc: {
              name: 'Duplicate',
              job: 'Goblin Negotiator',
              quirk: 'Believes they are a potato',
              mood: 'Dramatically bored',
              species: 'Goblin',
              alignment: 'Chaotic Neutral'
            }
          }
        end

        schema '$ref' => '#/components/schemas/ErrorResponse'

        example 'application/json', :duplicate_name_error, {
          error: 'Unprocessable Entity',
          message: 'Name has already been taken'
        }

        run_test!
      end
    end
  end
end
