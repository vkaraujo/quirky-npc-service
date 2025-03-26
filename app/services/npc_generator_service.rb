class NpcGeneratorService
  NAMES = [
    "Mibzle Gork", "Tilda Fizzlepot", "Brum the Quiet", "Zarnak Doomwhisper",
    "Pip Thimbletoe", "Glimmer Fernwhistle", "Snorgus the Flatulent", "Ellie of the Endless Tea"
  ]

  JOBS = [
    "wand polisher", "dragon dentist", "potion tester", "bard critic",
    "sock merchant", "wandering poet", "goblin negotiator", "beholder stylist"
  ]

  QUIRKS = [
    "only speaks in rhymes", "thinks they're invisible", "collects spoons",
    "scared of butterflies", "believes they're a potato", "hums constantly",
    "obsessed with ducks", "always narrating their actions"
  ]

  MOODS = [
    "mysteriously excited", "deeply confused", "overly confident", "melancholic but hopeful",
    "suspiciously friendly", "dramatically bored", "quietly panicked", "whimsically angry"
  ]

  SPECIES = [
    "Human", "Elf", "Dwarf", "Halfling", "Gnome", "Half-Orc", "Dragonborn", "Tiefling", "Goblin", "Fairy"
  ]

  ALIGNMENTS = [
    "Lawful Good", "Neutral Good", "Chaotic Good",
    "Lawful Neutral", "True Neutral", "Chaotic Neutral",
    "Lawful Evil", "Neutral Evil", "Chaotic Evil"
  ]

  def self.generate(params = {})
    {
      name: params[:name] || NAMES.sample,
      job: params[:job] || JOBS.sample,
      quirk: params[:quirk] || QUIRKS.sample,
      mood: params[:mood] || MOODS.sample,
      species: params[:species] || SPECIES.sample,
      alignment: params[:alignment] || ALIGNMENTS.sample
    }
  end
end
