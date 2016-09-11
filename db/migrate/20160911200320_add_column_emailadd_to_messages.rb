class AddColumnEmailaddToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :emailadd, :string
  end
end
