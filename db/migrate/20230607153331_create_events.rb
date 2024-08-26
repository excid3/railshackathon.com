class CreateEvents < ActiveRecord::Migration[7.0]
  def up
    create_table :events do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :theme
      t.string :title
      t.boolean :published, null: false, default: false

      t.timestamps
    end
  end

  def down
    drop_table :events
  end
end
