require 'test_helper'

class PriceRecordsControllerTest < ActionController::TestCase
  setup do
    @price_record = price_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:price_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create price_record" do
    assert_difference('PriceRecord.count') do
      post :create, price_record: { product_id: @price_record.product_id, psy_price: @price_record.psy_price, user_id: @price_record.user_id }
    end

    assert_redirected_to price_record_path(assigns(:price_record))
  end

  test "should show price_record" do
    get :show, id: @price_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @price_record
    assert_response :success
  end

  test "should update price_record" do
    patch :update, id: @price_record, price_record: { product_id: @price_record.product_id, psy_price: @price_record.psy_price, user_id: @price_record.user_id }
    assert_redirected_to price_record_path(assigns(:price_record))
  end

  test "should destroy price_record" do
    assert_difference('PriceRecord.count', -1) do
      delete :destroy, id: @price_record
    end

    assert_redirected_to price_records_path
  end
end
