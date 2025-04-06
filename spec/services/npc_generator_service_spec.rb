# frozen_string_literal: true

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
  end
end
