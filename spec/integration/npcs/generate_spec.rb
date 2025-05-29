# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'NPCs API', openapi_spec: 'v1/swagger.yaml', type: :request do
  path '/npcs/generate' do
    post 'Generate and save a random NPC' do
      description 'Generates and saves a random NPC with randomized attributes. Returns the created NPC or an error if generation fails.'
      tags 'Generation'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :body, in: :body, required: false, schema: {
        type: :object
      }

      response '200', 'NPC generated and saved' do
        schema '$ref' => '#/components/schemas/NpcResponse'

        example 'application/json', :npc_generated, {
          id: 101,
          name: 'Snorgus the Flatulent',
          job: 'Goblin Negotiator',
          quirk: 'Believes they are a potato',
          mood: 'Dramatically bored',
          species: 'Goblin',
          alignment: 'Chaotic Neutral',
          greeting: 'Greetings, I am Snorgus the Flatulent, your humble Goblin Negotiator!'
        }

        run_test!
      end

      response '422', 'Validation error (e.g., duplicate name)' do
        schema '$ref' => '#/components/schemas/ErrorResponse'

        example 'application/json', :validation_error, {
          error: 'Unprocessable Entity',
          message: 'Name has already been taken'
        }

        before do
          allow(NpcAttributes).to receive(:names).and_return(['Snorgus the Flatulent'])
          create(:npc, name: 'Snorgus the Flatulent')
        end

        run_test!
      end

      response '429', 'Rate limit exceeded' do
        schema '$ref' => '#/components/schemas/RateLimitResponse'

        example 'application/json', :rate_limit_error, {
          error: 'Too Many Requests',
          message: 'You have hit the rate limit for NPC generation'
        }

        run_test!
      end
    end
  end
end
