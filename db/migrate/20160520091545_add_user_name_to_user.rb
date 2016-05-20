class AddUserNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, unique: true, null: false, default: ""
  end
end
