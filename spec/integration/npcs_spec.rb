require 'swagger_helper'

RSpec.describe 'NPCs API', type: :request do
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
              name: { type: :string, example: 'Snorgus the Flatulent' },
              job: { type: :string, example: 'Goblin Negotiator' },
              quirk: { type: :string, example: 'Believes they are a potato' },
              mood: { type: :string, example: 'Dramatically bored' },
              species: {
                type: :string,
                enum: NpcAttributes.species
              },
              alignment: {
                type: :string,
                enum: NpcAttributes.alignments
              }
            },
            required: %w[name job quirk mood species alignment]
          }
        }
      }

      response '201', 'NPC created' do
        example 'application/json', :npc_response, {
          id: 42,
          name: "Snorgus the Flatulent",
          job: "Goblin Negotiator",
          quirk: "Believes they are a potato",
          mood: "Dramatically bored",
          species: "Goblin",
          alignment: "Chaotic Neutral",
          greeting: "Greetings, I am Snorgus the Flatulent, your humble Goblin Negotiator!"
        }

        let(:npc) do
          {
            npc: {
              name: "Snorgus the Flatulent",
              job: "Goblin Negotiator",
              quirk: "Believes they are a potato",
              mood: "Dramatically bored",
              species: "Goblin",
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
              name: { type: :string, example: 'Tilda Fizzlepot' },
              job: { type: :string, example: 'Potion Tester' },
              quirk: { type: :string, example: 'Only speaks in rhymes' },
              mood: { type: :string, example: 'Melancholic but hopeful' },
              species: {
                type: :string,
                enum: NpcAttributes.species,
                example: 'Halfling'
              },
              alignment: {
                type: :string,
                enum: NpcAttributes.alignments,
                example: 'Lawful Good'
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
          name: { type: :string, example: 'Brum the Quiet' },
          job: { type: :string, example: 'Wand Polisher' },
          quirk: { type: :string, example: 'Collects spoons' },
          mood: { type: :string, example: 'Mysteriously excited' },
          species: {
            type: :string,
            enum: NpcAttributes.species,
            example: 'Elf'
          },
          alignment: {
            type: :string,
            enum: NpcAttributes.alignments,
            example: 'True Neutral'
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
