class AddEventToVotes < ActiveRecord::Migration[7.0]
  def change
    add_reference :votes, :event, null: false, foreign_key: true

    Vote.reset_column_information

    Vote.acts_as_list_no_update do
      Vote.find_each do |vote|
        vote.update!(event: vote.entry.event)
      end
    end
  end
end
