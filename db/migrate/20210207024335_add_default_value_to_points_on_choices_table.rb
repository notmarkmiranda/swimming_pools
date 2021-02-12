class AddDefaultValueToPointsOnChoicesTable < ActiveRecord::Migration[6.1]
  def up
    change_column :choices, :points, :integer, default: 1
  end

  def down
    change_column :choices, :points, :integer, default: nil
  end
end
