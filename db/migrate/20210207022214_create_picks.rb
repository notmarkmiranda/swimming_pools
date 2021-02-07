class CreatePicks < ActiveRecord::Migration[6.1]
  def change
    create_table :picks do |t|
      t.references :entry, null: false, foreign_key: true
      t.references :choice, null: false, foreign_key: true
      t.boolean :correct
      t.integer :points, default: 1

      t.timestamps null: false
    end
  end
end
