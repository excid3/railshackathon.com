class AddCompleteToEntries < ActiveRecord::Migration[7.0]
  def change
    add_column :entries, :complete, :boolean
  end
end
