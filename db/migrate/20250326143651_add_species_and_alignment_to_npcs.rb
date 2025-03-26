class AddSpeciesAndAlignmentToNpcs < ActiveRecord::Migration[7.1]
  def change
    add_column :npcs, :species, :string
    add_column :npcs, :alignment, :string
  end
end
