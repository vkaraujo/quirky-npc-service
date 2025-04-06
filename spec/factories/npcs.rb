# frozen_string_literal: true

FactoryBot.define do
  factory :npc do
    name { 'Test NPC' }
    job { 'Potion Tester' }
    quirk { 'Collects spoons' }
    mood { 'Mysteriously excited' }
    species { NpcAttributes.species.first }
    alignment { NpcAttributes.alignments.first }
  end
end
