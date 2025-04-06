# frozen_string_literal: true

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
