class AddVotesCountToEntries < ActiveRecord::Migration[7.0]
  def change
    add_column :entries, :votes_count, :integer
  end
end
