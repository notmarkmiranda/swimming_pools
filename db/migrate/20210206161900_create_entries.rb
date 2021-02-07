class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pool, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
