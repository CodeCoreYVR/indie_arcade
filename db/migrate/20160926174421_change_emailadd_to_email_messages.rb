class ChangeEmailaddToEmailMessages < ActiveRecord::Migration[5.0]
  def change
    rename_column :messages, :emailadd, :email
  end
end
