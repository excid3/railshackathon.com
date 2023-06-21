class AddStartTimeLinkToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :start_time_link, :string
  end
end
