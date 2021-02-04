class CreatePools < ActiveRecord::Migration[6.1]
  def change
    create_table :pools do |t|
      t.string :name
      t.string :associated_game
      t.date :date
      t.boolean :multiple_entries
      t.boolean :completed, default: false
      t.references :user, null: false, foreign_key: true
      t.string :invite_code

      t.timestamps null: false
    end
  end
end
