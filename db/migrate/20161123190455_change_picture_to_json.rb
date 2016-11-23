class ChangePictureToJson < ActiveRecord::Migration[5.0]
  def change
    remove_column :games, :picture, :string
    add_column :games, :pictures, :string, array:true, default:[]
  end
end
