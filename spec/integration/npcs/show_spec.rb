# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'NPCs API', openapi_spec: 'v1/swagger.yaml', type: :request do
  path '/npcs/{id}' do
    get 'Retrieve a specific NPC by ID' do
      tags 'NPC Management'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'NPC found' do
        let(:id) { create(:npc).id }

        schema '$ref' => '#/components/schemas/Npc'

        example 'application/json', :npc_response, {
          id: 1,
          name: 'Tilda Fizzlepot',
          job: 'Potion Tester',
          quirk: 'Only speaks in rhymes',
          mood: 'Suspiciously friendly',
          species: 'Gnome',
          alignment: 'Chaotic Neutral',
          greeting: 'Greetings, I am Tilda Fizzlepot, your humble Potion Tester!'
        }

        run_test!
      end

      response '404', 'NPC not found' do
        let(:id) { 99_999 }

        schema '$ref' => '#/components/schemas/NotFoundResponse'

        example 'application/json', :not_found_error, {
          error: 'Not Found',
          message: "Couldn't find Npc with id=99"
        }

        run_test!
      end
    end
  end
end
