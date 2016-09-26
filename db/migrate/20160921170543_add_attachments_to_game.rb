class AddAttachmentsToGame < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :attachment, :string
  end
end
