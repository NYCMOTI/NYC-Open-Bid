class AddFmsNumberToUser < ActiveRecord::Migration
  def change
    add_column :users, :fms_number, :string, null: false, default: ""
    add_column :users, :fms_status, :integer, null: false, default: 0
    add_index :users, :fms_status
  end
end