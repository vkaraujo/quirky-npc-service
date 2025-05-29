# frozen_string_literal: true

class NpcGeneratorService
  def self.generate
    {
      name: NpcNameService.generate_unique_name,
      job: NpcAttributes.jobs.sample,
      quirk: NpcAttributes.quirks.sample,
      mood: NpcAttributes.moods.sample,
      species: NpcAttributes.species.sample,
      alignment: NpcAttributes.alignments.sample
    }
  end
end
