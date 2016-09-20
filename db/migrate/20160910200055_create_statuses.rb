class CreateStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :statuses do |t|
      t.string :name

      t.timestamps
    end

    add_column :games, :status_id, :integer
    add_index :games, :status_id
  end
end
