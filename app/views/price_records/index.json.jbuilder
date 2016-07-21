json.array!(@price_records) do |price_record|
  json.extract! price_record, :id, :user_id, :product_id, :psy_price
  json.url price_record_url(price_record, format: :json)
end
