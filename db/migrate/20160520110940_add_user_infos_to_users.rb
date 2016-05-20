class AddUserInfosToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :date_birthday, :date
  	add_column :users, :sexe, :string
  	add_column :users, :category_favorite, :string
  	add_column :users, :last_name, :string
  	add_column :users, :first_name, :string
  end
end
