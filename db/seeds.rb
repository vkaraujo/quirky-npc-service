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

NAMES = [
  "Mibzle Gork", "Tilda Fizzlepot", "Brum the Quiet", "Zarnak Doomwhisper",
  "Pip Thimbletoe", "Glimmer Fernwhistle", "Snorgus the Flatulent", "Ellie of the Endless Tea"
]

JOBS = [
  "wand polisher", "dragon dentist", "potion tester", "bard critic",
  "sock merchant", "wandering poet", "goblin negotiator", "beholder stylist"
]

QUIRKS = [
  "only speaks in rhymes", "thinks they're invisible", "collects spoons",
  "scared of butterflies", "believes they're a potato", "hums constantly",
  "obsessed with ducks", "always narrating their actions"
]

MOODS = [
  "mysteriously excited", "deeply confused", "overly confident", "melancholic but hopeful",
  "suspiciously friendly", "dramatically bored", "quietly panicked", "whimsically angry"
]

20.times do
  Npcs << Npc.create!(
    name: NAMES.sample,
    job: JOBS.sample,
    quirk: QUIRKS.sample,
    mood: MOODS.sample
  )
end

puts "🌟 Seeded #{Npcs.count} NPCs!"
