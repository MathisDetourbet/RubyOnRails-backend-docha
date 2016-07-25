class AddRecordDataToPriceRecords < ActiveRecord::Migration
  def change
    add_column :price_records, :is_in_intervalle, :boolean
    add_column :price_records, :response_time, :decimal
    add_column :price_records, :had_time_to_give_answer, :boolean
  end
end
