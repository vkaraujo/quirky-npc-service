class AddIndexToNpcsNameUnique < ActiveRecord::Migration[7.1]
  def change
    add_index :npcs, :name, unique: true
  end
end
