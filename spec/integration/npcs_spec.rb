require 'swagger_helper'

RSpec.describe 'NPCs API', type: :request do
  path '/npcs' do
    get 'List all NPCs' do
      tags 'NPC Management'
      produces 'application/json'
      parameter name: :species, in: :query, schema: {
        type: :string,
        enum: Npc::SPECIES
      }, description: 'Filter NPCs by species (e.g. Elf, Goblin, Fairy)'

      parameter name: :alignment, in: :query, schema: {
        type: :string,
        enum: Npc::ALIGNMENTS
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

        run_test!
      end
    end

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
              name: { type: :string },
              job: { type: :string },
              quirk: { type: :string },
              mood: { type: :string },
              species: {
                type: :string,
                enum: Npc::SPECIES
              },
              alignment: {
                type: :string,
                enum: Npc::ALIGNMENTS
              }
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
      tags 'NPC Management'
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

    patch 'Update an existing NPC' do
      tags 'NPC Management'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer
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
              species: {
                type: :string,
                enum: Npc::SPECIES
              },
              alignment: {
                type: :string,
                enum: Npc::ALIGNMENTS
              }
            }
          }
        }
      }

      response '200', 'NPC updated' do
        let(:id) { create(:npc).id }
        let(:npc) do
          {
            npc: {
              mood: 'suspiciously friendly',
              quirk: 'believes they are a potato'
            }
          }
        end

        run_test!
      end

      response '404', 'NPC not found' do
        let(:id) { 99999 }
        let(:npc) { { npc: { mood: 'dramatically bored' } } }
        run_test!
      end
    end

    delete 'Delete an NPC' do
      tags 'NPC Management'
      parameter name: :id, in: :path, type: :integer

      response '204', 'NPC deleted' do
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
      tags 'Generation'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :npc, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          job: { type: :string },
          quirk: { type: :string },
          mood: { type: :string },
          species: {
            type: :string,
            enum: Npc::SPECIES
          },
          alignment: {
            type: :string,
            enum: Npc::ALIGNMENTS
          }
        }
      }

      response '200', 'NPC generated' do
        let(:npc) { {} }
        run_test!
      end
    end
  end
end
