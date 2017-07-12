class AddMwbeStatus < ActiveRecord::Migration
  def change
    add_column :users, :is_mwbe, :boolean, default: false, null: false
  end
end
