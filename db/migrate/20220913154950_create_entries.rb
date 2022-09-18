class CreateEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :entries do |t|
      t.string :title
      t.string :website_url
      t.string :github_url
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
