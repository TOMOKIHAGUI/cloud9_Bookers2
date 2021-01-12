class RemoveColumnsInUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :adress_street, :string
    remove_column :users, :adress_building, :string
  end
end
