class Npc < ApplicationRecord
  validates :job, :quirk, :mood, presence: true
  validates :species, inclusion: { in: NpcAttributes.species }
  validates :alignment, inclusion: { in: NpcAttributes.alignments }
  validates :name, presence: true, uniqueness: { case_sensitive: false }

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

  def greeting
    "Greetings, I am #{self.name}, your humble #{self.job}!"
  end
end
