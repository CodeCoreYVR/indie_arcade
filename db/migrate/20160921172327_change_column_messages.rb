class ChangeColumnMessages < ActiveRecord::Migration[5.0]
  def change
    rename_column :messages, :email, :email
  end
end
