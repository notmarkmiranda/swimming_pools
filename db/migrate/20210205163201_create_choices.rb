class CreateChoices < ActiveRecord::Migration[6.1]
  def change
    create_table :choices do |t|
      t.references :question, null: false, foreign_key: true
      t.string :text
      t.boolean :correct
      t.integer :points

      t.timestamps
    end
  end
end
