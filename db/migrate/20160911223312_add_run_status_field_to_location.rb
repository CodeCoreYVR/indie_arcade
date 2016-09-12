class AddRunStatusFieldToLocation < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :run_status, :string
  end
end
