# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NpcSerializer, type: :serializer do
  let(:npc) do
    build(:npc, name: 'Tilda', job: 'Potion Tester', quirk: 'Collects spoons',
                mood: 'Whimsically angry', species: 'Gnome', alignment: 'Chaotic Good')
  end

  let(:serialized) { described_class.new(npc).as_json }

  it 'includes all expected attributes' do
    expect(serialized).to include(
      id: nil,
      name: 'Tilda',
      job: 'Potion Tester',
      quirk: 'Collects spoons',
      mood: 'Whimsically angry',
      species: 'Gnome',
      alignment: 'Chaotic Good',
      greeting: 'Greetings, I am Tilda, your humble Potion Tester!'
    )
  end
end
