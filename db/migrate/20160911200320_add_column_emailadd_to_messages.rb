class AddColumnemailToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :email, :string
  end
end
