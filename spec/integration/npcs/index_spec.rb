require 'swagger_helper'

RSpec.describe 'NPCs API', openapi_spec: 'v1/swagger.yaml', type: :request do
  path '/npcs' do
    get 'List all NPCs' do
      tags 'NPC Management'
      produces 'application/json'
      parameter name: :species, in: :query, schema: {
        type: :string,
        enum: NpcAttributes.species
      }, description: 'Filter NPCs by species (e.g. Elf, Goblin, Fairy)'

      parameter name: :alignment, in: :query, schema: {
        type: :string,
        enum: NpcAttributes.alignments
      }, description: 'Filter NPCs by D&D alignment (e.g. Chaotic Neutral)'

      parameter name: :page, in: :query, type: :integer, description: 'Page number'

      let(:species) { nil }
      let(:alignment) { nil }
      let(:page) { 1 }

      response '200', 'NPCs retrieved' do
        schema type: :object,
               properties: {
                 npcs: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       name: { type: :string },
                       job: { type: :string },
                       quirk: { type: :string },
                       mood: { type: :string },
                       species: { type: :string },
                       alignment: { type: :string },
                       greeting: { type: :string }
                     }
                   }
                 },
                 pagination: {
                   type: :object,
                   properties: {
                     page: { type: :integer },
                     items: { type: :integer },
                     pages: { type: :integer },
                     count: { type: :integer }
                   }
                 }
               }

        before do
          create_list(:npc, 3)
        end

        example 'application/json', :npc_index_response, {
          npcs: [
            {
              id: 1,
              name: "Zarnak Doomwhisper",
              job: "Dragon Dentist",
              quirk: "Obsessed with ducks",
              mood: "Quietly panicked",
              species: "Half-Orc",
              alignment: "Chaotic Evil",
              greeting: "Greetings, I am Zarnak Doomwhisper, your humble Dragon Dentist!"
            },
            {
              id: 2,
              name: "Tilda Fizzlepot",
              job: "Potion Tester",
              quirk: "Only speaks in rhymes",
              mood: "Suspiciously friendly",
              species: "Gnome",
              alignment: "Chaotic Neutral",
              greeting: "Greetings, I am Tilda Fizzlepot, your humble Potion Tester!"
            }
          ],
          pagination: {
            page: 1,
            items: 5,
            pages: 1,
            count: 2
          }
        }

        run_test!
      end
    end
  end
end
