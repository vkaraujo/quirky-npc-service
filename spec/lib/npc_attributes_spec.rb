require 'rails_helper'

RSpec.describe NpcAttributes do
  it 'loads all categories from the YAML file' do
    expect(NpcAttributes.names).to all(be_a(String))
    expect(NpcAttributes.species).to include("Elf", "Goblin")
    expect(NpcAttributes.alignments).to include("Chaotic Neutral")
  end
end
