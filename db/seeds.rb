# frozen_string_literal: true

require 'faker'

Npcs = []

NpcAttributes.names.shuffle.take(20).each do |unique_name|
  Npcs << Npc.create!(
    name: unique_name,
    job: NpcAttributes.jobs.sample,
    quirk: NpcAttributes.quirks.sample,
    mood: NpcAttributes.moods.sample,
    species: NpcAttributes.species.sample,
    alignment: NpcAttributes.alignments.sample
  )
end

puts "🌟 Seeded #{Npcs.count} unique NPCs!"
