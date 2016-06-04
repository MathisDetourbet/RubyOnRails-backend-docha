class AddFacebookInfosToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fb_id, :string, unique: true
    add_column :users, :fb_image_url, :string
    add_column :users, :fb_token, :string, null: false, default: ""
  end
end
