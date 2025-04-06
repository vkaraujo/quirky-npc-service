# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Npc, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:job) }
    it { should validate_presence_of(:quirk) }
    it { should validate_presence_of(:mood) }
    it { should validate_inclusion_of(:species).in_array(NpcAttributes.species) }
    it { should validate_inclusion_of(:alignment).in_array(NpcAttributes.alignments) }
  end

  describe '#greeting' do
    it 'returns a formatted greeting string' do
      npc = build(:npc, name: 'Zarnak', job: 'Dragon Dentist')
      expect(npc.greeting).to eq('Greetings, I am Zarnak, your humble Dragon Dentist!')
    end
  end

  describe 'scopes' do
    let!(:elf)  { create(:npc, species: 'Elf') }
    let!(:orc)  { create(:npc, species: 'Half-Orc') }

    it '.by_species returns only matching species' do
      expect(Npc.by_species('Elf')).to contain_exactly(elf)
    end

    it '.by_alignment returns only matching alignment' do
      chaotic = create(:npc, alignment: 'Chaotic Good')
      expect(Npc.by_alignment('Chaotic Good')).to include(chaotic)
    end
  end
end
