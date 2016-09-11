class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :company
      t.string :email
      t.string :password_digest
      t.string :logo
      t.integer :employees
      t.string :genres
      t.string :website
      t.string :twitter
      t.boolean :admin

      t.timestamps
    end
  end
end
