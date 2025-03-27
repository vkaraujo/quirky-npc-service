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
    end
  end
end
