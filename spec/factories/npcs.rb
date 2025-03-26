FactoryBot.define do
  factory :npc do
    name { "MyString" }
    job { "MyString" }
    quirk { "MyString" }
    mood { "MyString" }
    species { Npc::SPECIES.sample }
    alignment { Npc::ALIGNMENTS.sample }
  end
end
