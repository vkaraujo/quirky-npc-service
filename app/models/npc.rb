class Npc < ApplicationRecord
  SPECIES = [
    "Human", "Elf", "Dwarf", "Halfling", "Gnome", "Half-Orc", "Dragonborn", "Tiefling", "Goblin", "Fairy"
  ]

  ALIGNMENTS = [
    "Lawful Good", "Neutral Good", "Chaotic Good",
    "Lawful Neutral", "True Neutral", "Chaotic Neutral",
    "Lawful Evil", "Neutral Evil", "Chaotic Evil"
  ]

  scope :by_species, ->(species) do
    return all unless species.present?

    normalized = species.strip.titleize
    raise ArgumentError, "Invalid species: #{species}" unless SPECIES.include?(normalized)
    where(species: normalized)
  end

  scope :by_alignment, ->(alignment) do
    return all unless alignment.present?

    normalized = alignment.strip.titleize
    raise ArgumentError, "Invalid alignment: #{alignment}" unless ALIGNMENTS.include?(normalized)
    where(alignment: normalized)
  end
end
