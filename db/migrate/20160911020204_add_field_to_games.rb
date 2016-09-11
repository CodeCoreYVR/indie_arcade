class AddFieldToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :description, :text
    add_column :games, :picture, :string
    add_column :games, :link, :string
  end
end
