# frozen_string_literal: true

class NpcNameService
  MAX_ATTEMPTS = 10

  def self.generate_unique_name
    attempts = 0

    loop do
      name = "#{fetch_fantasy_name} #{quirky_suffix}"
      return name unless Npc.exists?(name: name)

      attempts += 1
      raise "Failed to generate unique name after #{MAX_ATTEMPTS} attempts" if attempts >= MAX_ATTEMPTS
    end
  end

  def self.fetch_fantasy_name
    [
      Faker::Games::DnD.name,
      Faker::Games::ElderScrolls.name
    ].sample
  end

  def self.quirky_suffix
    NpcAttributes.suffixes.sample
  end
end
