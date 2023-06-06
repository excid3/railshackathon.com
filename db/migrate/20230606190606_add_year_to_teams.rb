class AddYearToTeams < ActiveRecord::Migration[7.0]
  def up
    add_column :teams, :year, :integer
    
    Team.find_each do |team|
      puts "Updating Team with id: #{team.id}"
      team.update! year: 2022
      puts "Successfully updated Team with id: #{team.id}"
    end
  end
  
  def down
    remove_column :teams, :year, :integer
  end
end
