class AddKeyMapToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :key_map, :json
  end
end
