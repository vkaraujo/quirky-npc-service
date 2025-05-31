# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'NPCs API', openapi_spec: 'v1/swagger.yaml', type: :request do
  path '/npcs/{id}' do
    delete 'Delete an NPC' do
      tags 'NPC Management'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer

      response '204', 'NPC deleted' do
        let(:id) { create(:npc).id }
        run_test!
      end

      response '404', 'NPC not found' do
        let(:id) { 99_999 }

        schema '$ref' => '#/components/schemas/NotFoundResponse'

        example 'application/json', :npc_not_found, {
          error: 'Not Found',
          message: "Couldn't find Npc with id=99999"
        }

        run_test!
      end
    end
  end
end
