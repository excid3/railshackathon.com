class AddTotalPointsToEntries < ActiveRecord::Migration[7.0]
  def change
    add_column :entries, :total_points, :integer, default: 0
  end
end
