class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.references :pool, null: false, foreign_key: true
      t.string :text

      t.timestamps null: false
    end
  end
end
