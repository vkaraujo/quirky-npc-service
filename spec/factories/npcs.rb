# frozen_string_literal: true

FactoryBot.define do
  FactoryBot.define do
    factory :npc do
      name      { NpcNameService.generate_unique_name }
      job       { NpcAttributes.jobs.sample }
      quirk     { NpcAttributes.quirks.sample }
      mood      { NpcAttributes.moods.sample }
      species   { NpcAttributes.species.sample }
      alignment { NpcAttributes.alignments.sample }
    end
  end
end
