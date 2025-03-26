require 'swagger_helper'

RSpec.describe 'NPCs API', type: :request do
  path '/npcs' do
    get 'List all NPCs' do
      tags 'NPCs'
      produces 'application/json'
      parameter name: :species, in: :query, type: :string, description: 'Filter by species'
      parameter name: :alignment, in: :query, type: :string, description: 'Filter by alignment'
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

        run_test!
      end
    end

    post 'Create a new NPC' do
      tags 'NPCs'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :npc, in: :body, schema: {
        type: :object,
        properties: {
          npc: {
            type: :object,
            properties: {
              name: { type: :string },
              job: { type: :string },
              quirk: { type: :string },
              mood: { type: :string },
              species: { type: :string },
              alignment: { type: :string }
            },
            required: %w[name job quirk mood species alignment]
          }
        }
      }

      response '201', 'NPC created' do
        let(:npc) do
          {
            npc: {
              name: "Flimble Tweak",
              job: "Potion Tester",
              quirk: "collects spoons",
              mood: "quietly panicked",
              species: "Gnome",
              alignment: "Chaotic Neutral"
            }
          }
        end

        run_test!
      end
    end
  end

  path '/npcs/{id}' do
    get 'Retrieve a specific NPC by ID' do
      tags 'NPCs'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'NPC found' do
        let(:id) { create(:npc).id }
        run_test!
      end

      response '404', 'NPC not found' do
        let(:id) { 99999 }
        run_test!
      end
    end
  end

  path '/npcs/generate' do
    post 'Generate a random, ephemeral NPC' do
      tags 'NPCs'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :npc, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          job: { type: :string },
          quirk: { type: :string },
          mood: { type: :string },
          species: { type: :string },
          alignment: { type: :string }
        }
      }

      response '200', 'NPC generated' do
        let(:npc) { {} }
        run_test!
      end
    end
  end
end
