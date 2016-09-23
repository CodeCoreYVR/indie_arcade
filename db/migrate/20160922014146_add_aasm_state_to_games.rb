class AddAasmStateToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :aasm_state, :string
  end
end
