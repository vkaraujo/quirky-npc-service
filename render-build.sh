#!/usr/bin/env bash

# Install dependencies
bundle install

# Run migrations
bundle exec rake db:migrate

# Optional: Seed database
bundle exec rake db:seed
