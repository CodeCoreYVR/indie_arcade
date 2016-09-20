class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :fun
      t.integer :playability
      t.integer :difficulty
      t.references :load, foreign_key: true

      t.timestamps
    end
  end
end
