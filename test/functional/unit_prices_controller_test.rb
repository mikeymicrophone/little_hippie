require 'test_helper'

class UnitPricesControllerTest < ActionController::TestCase
  setup do
    @unit_price = unit_prices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:unit_prices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create unit_price" do
    assert_difference('UnitPrice.count') do
      post :create, unit_price: {  }
    end

    assert_redirected_to unit_price_path(assigns(:unit_price))
  end

  test "should show unit_price" do
    get :show, id: @unit_price
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @unit_price
    assert_response :success
  end

  test "should update unit_price" do
    put :update, id: @unit_price, unit_price: {  }
    assert_redirected_to unit_price_path(assigns(:unit_price))
  end

  test "should destroy unit_price" do
    assert_difference('UnitPrice.count', -1) do
      delete :destroy, id: @unit_price
    end

    assert_redirected_to unit_prices_path
  end
end
