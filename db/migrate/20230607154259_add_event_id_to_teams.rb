class AddEventIdToTeams < ActiveRecord::Migration[7.0]
  def up
    add_reference :teams, :event, foreign_key: true

    event = Event.find_by(theme: "Hotwire")
    Team.update_all(event_id: event.id) if event

    change_column_null :teams, :event_id, false
  end

  def down
    remove_reference :teams, :event, foreign_key: true
  end
end
