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
    
    Event.create!(theme: "Hotwire",
                  title: "Hotwire",
                  start_time: DateTime.new(2022, 9, 16, 19, 0, 00),
                  end_time: DateTime.new(2022, 9, 18, 19, 0, 00),
                  published: true
                )
                
    Event.create!(theme: "Supporting the Ruby on Rails Community",
                  title: "Supporting Rails",
                  start_time: DateTime.new(2023, 7, 28, 19, 0, 00),
                  end_time: DateTime.new(2023, 7, 30, 19, 0, 00),
                  published: true
                )          
  end
  
  def down
    drop_table :events
  end
end
