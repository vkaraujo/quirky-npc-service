class NpcAttributes
  def self.all
    @all ||= YAML.load_file(Rails.root.join('config/npc_attributes.yml')).with_indifferent_access
  end

  def self.names      = all[:names]
  def self.jobs       = all[:jobs]
  def self.quirks     = all[:quirks]
  def self.moods      = all[:moods]
  def self.species    = all[:species]
  def self.alignments = all[:alignments]
end
