class AddRewardsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dochos, :integer, null: false, default: 0
    add_column :users, :perfects, :integer, null: false, default: 0
    add_column :users, :experience, :integer, null: false, default: 0
    add_column :users, :levelUser, :integer, null: false, default: 1
  end
end
