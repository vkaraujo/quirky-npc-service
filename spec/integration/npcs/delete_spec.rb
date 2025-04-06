# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'NPCs API', openapi_spec: 'v1/swagger.yaml', type: :request do
  path '/npcs/{id}' do
    delete 'Delete an NPC' do
      tags 'NPC Management'
      parameter name: :id, in: :path, type: :integer

      response '204', 'NPC deleted' do
        let(:id) { create(:npc).id }
        run_test!
      end

      response '404', 'NPC not found' do
        let(:id) { 99_999 }
        run_test!
      end
    end
  end
end
