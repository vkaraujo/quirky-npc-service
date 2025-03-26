class CreateNpcs < ActiveRecord::Migration[7.1]
  def change
    create_table :npcs do |t|
      t.string :name
      t.string :job
      t.string :quirk
      t.string :mood

      t.timestamps
    end
  end
end
