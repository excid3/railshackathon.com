class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :time_zone
      t.string :github_repo

      t.timestamps
    end
  end
end
