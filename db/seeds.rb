# frozen_string_literal: true

Npcs = []

20.times do
  Npcs << Npc.create!(
    name: NpcNameService.generate_unique_name,
    job: NpcAttributes.jobs.sample,
    quirk: NpcAttributes.quirks.sample,
    mood: NpcAttributes.moods.sample,
    species: NpcAttributes.species.sample,
    alignment: NpcAttributes.alignments.sample
  )
end

puts "🌟 Seeded #{Npcs.count} NPCs!"
