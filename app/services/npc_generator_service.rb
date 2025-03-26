class NpcGeneratorService
  def self.generate(params = {})
    {
      name: params[:name] || NpcAttributes.names.sample,
      job: params[:job] || NpcAttributes.jobs.sample,
      quirk: params[:quirk] || NpcAttributes.quirks.sample,
      mood: params[:mood] || NpcAttributes.moods.sample,
      species: params[:species] || NpcAttributes.species.sample,
      alignment: params[:alignment] || NpcAttributes.alignments.sample
    }
  end
end
