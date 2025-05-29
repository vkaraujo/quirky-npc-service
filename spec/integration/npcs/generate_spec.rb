# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'NPCs API', openapi_spec: 'v1/swagger.yaml', type: :request do
  path '/npcs/generate' do
    post 'Generate a random, ephemeral NPC' do
      description 'This endpoint creates a new NPC using randomized values for every attribute. You don’t need to send anything — just click Execute!'
      tags 'Generation'
      produces 'application/json'

      response '200', 'NPC generated' do
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
