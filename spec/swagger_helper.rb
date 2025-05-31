# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.openapi_root = Rails.root.join('swagger').to_s

  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      tags: [
        {
          name: 'NPC Management',
          description: 'CRUD endpoints for managing saved NPCs'
        },
        {
          name: 'Generation',
          description: 'Endpoints that generate random, ephemeral NPCs'
        }
      ],
      paths: {},
      servers: [
        {
          url: ENV.fetch('SWAGGER_API_HOST', 'http://localhost:3000'),
          description: 'Current environment server'
        }
      ],
      components: {
        schemas: {
          Npc: {
            type: :object,
            properties: {
              id: { type: :integer, example: 42 },
              name: { type: :string, example: 'Tilda Fizzlepot' },
              job: { type: :string, example: 'sock merchant' },
              quirk: { type: :string, example: 'hums constantly' },
              mood: { type: :string, example: 'quietly panicked' },
              species: { type: :string, example: 'Elf' },
              alignment: { type: :string, example: 'Chaotic Good' },
              created_at: { type: :string, format: :date_time },
              updated_at: { type: :string, format: :date_time },
              generated_by: { type: :string, example: 'generator' }
            }
          },
          ErrorResponse: {
            type: :object,
            properties: {
              error: { type: :string, example: 'Unprocessable Entity' },
              message: { type: :string, example: 'Name can\'t be blank' }
            }
          },
          NotFoundResponse: {
            type: :object,
            properties: {
              error: { type: :string, example: 'Not Found' },
              message: { type: :string, example: 'Couldn\'t find Npc with id=999' }
            }
          },
          BadRequestResponse: {
            type: :object,
            properties: {
              error: { type: :string, example: 'Bad Request' },
              message: { type: :string, example: 'param is missing or the value is empty: npc' }
            }
          },
          RateLimitResponse: {
            type: :object,
            properties: {
              error: { type: :string, example: 'Too Many Requests' },
              message: { type: :string, example: 'You have hit the rate limit for NPC generation' }
            }
          },
          NpcCreateAttributes: {
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
          },
          NpcRequest: {
            type: :object,
            properties: {
              npc: {
                '$ref': '#/components/schemas/NpcCreateAttributes'
              }
            },
            required: ['npc']
          },
          NpcResponse: {
            allOf: [
              { '$ref': '#/components/schemas/Npc' },
              {
                type: :object,
                properties: {
                  greeting: {
                    type: :string,
                    example: 'Greetings, I am Snorgus the Flatulent, your humble Goblin Negotiator!'
                  }
                }
              }
            ]
          },
          NpcUpdateAttributes: {
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
          },
          NpcUpdateRequest: {
            type: :object,
            properties: {
              npc: {
                '$ref': '#/components/schemas/NpcUpdateAttributes'
              }
            },
            required: ['npc']
          }
        }
      }
    }
  }

  config.openapi_format = :yaml
  config.include FactoryBot::Syntax::Methods
end
