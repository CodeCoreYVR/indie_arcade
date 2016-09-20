class CreateLoads < ActiveRecord::Migration[5.0]
  def change
    create_table :loads do |t|
      t.references :game, foreign_key: true
      t.references :machine, foreign_key: true

      t.timestamps
    end
  end
end
