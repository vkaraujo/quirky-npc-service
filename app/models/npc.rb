class Npc < ApplicationRecord
  scope :by_species, ->(species) { where(species: species) if species.present? }
  scope :by_alignment, ->(alignment) { where(alignment: alignment) if alignment.present? }
end
