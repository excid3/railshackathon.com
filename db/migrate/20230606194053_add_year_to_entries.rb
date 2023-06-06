class AddYearToEntries < ActiveRecord::Migration[7.0]
  def up
    add_column :entries, :year, :integer
    
    Entry.find_each do |entry|
      puts "Updating Entry with id: #{entry.id}"
      entry.update! year: 2022
      puts "Successfully updated Entry with id: #{entry.id}"
    end
  end
  
  def down
    remove_column :entries, :year, :integer
  end
end
