class CreatePriceRecords < ActiveRecord::Migration
  def change
    create_table :price_records do |t|
      t.integer :user_id
      t.integer :product_id
      t.integer :psy_price

      t.timestamps null: false
    end
  end
end
