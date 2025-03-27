class NpcGeneratorService
  def self.generate
    {
      name:     NpcAttributes.names.sample,
      job:      NpcAttributes.jobs.sample,
      quirk:    NpcAttributes.quirks.sample,
      mood:     NpcAttributes.moods.sample,
      species:  NpcAttributes.species.sample,
      alignment: NpcAttributes.alignments.sample
    }
  end
end
