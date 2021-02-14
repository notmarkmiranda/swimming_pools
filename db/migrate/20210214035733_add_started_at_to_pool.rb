class AddStartedAtToPool < ActiveRecord::Migration[6.1]
  def change
    add_column :pools, :started_at, :datetime
  end
end
