class Npc < ApplicationRecord
  SPECIES = NpcAttributes.species
  ALIGNMENTS = NpcAttributes.alignments

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
