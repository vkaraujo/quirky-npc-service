# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

require 'faker'

Npcs = []

20.times do
  Npcs << Npc.create!(
    name: NpcAttributes.names.sample,
    job: NpcAttributes.jobs.sample,
    quirk: NpcAttributes.quirks.sample,
    mood: NpcAttributes.moods.sample,
    species: NpcAttributes.species.sample,
    alignment: NpcAttributes.alignments.sample
  )
end

puts "🌟 Seeded #{Npcs.count} NPCs!"
