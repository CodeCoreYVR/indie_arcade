class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :title
      t.float :cpu
      t.float :gpu
      t.float :ram
      t.float :size
      t.datetime :approval_date
      t.string :current_status
      t.text :stats
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
