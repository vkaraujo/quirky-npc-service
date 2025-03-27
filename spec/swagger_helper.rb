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
      ]
    }
  }

  config.openapi_format = :yaml
  config.include FactoryBot::Syntax::Methods
end
