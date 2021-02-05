class CreateMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pool, null: false, foreign_key: true
      t.integer :role, default: 0

      t.timestamps null: false
    end
  end
end
