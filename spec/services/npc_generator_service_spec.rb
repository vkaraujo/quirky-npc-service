require 'rails_helper'

RSpec.describe NpcGeneratorService do
  describe '.generate' do
    context 'when no params are given' do
      it 'returns a valid random NPC hash' do
        npc = described_class.generate

        expect(npc).to include(
          name: be_a(String),
          job: be_a(String),
          quirk: be_a(String),
          mood: be_a(String),
          species: be_a(String),
          alignment: be_a(String)
        )
      end
    end

    context 'when some params are given' do
      it 'overrides fields with provided values' do
        npc = described_class.generate(name: 'Brum', job: 'Dragon Dentist')

        expect(npc[:name]).to eq('Brum')
        expect(npc[:job]).to eq('Dragon Dentist')
        expect(npc[:quirk]).to be_a(String)
        expect(npc[:species]).to be_in(NpcAttributes.species)
      end
    end
  end
end
