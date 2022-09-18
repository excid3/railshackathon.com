class AddVotesCountToEntries < ActiveRecord::Migration[7.0]
  def change
    add_column :entries, :votes_count, :integer, default: 0
  end
end
