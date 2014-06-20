require 'test_helper'

class WholesaleOrdersControllerTest < ActionController::TestCase
  setup do
    @wholesale_order = wholesale_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wholesale_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wholesale_order" do
    assert_difference('WholesaleOrder.count') do
      post :create, wholesale_order: { reseller_id: @wholesale_order.reseller_id, shipping_address_id: @wholesale_order.shipping_address_id, status: @wholesale_order.status }
    end

    assert_redirected_to wholesale_order_path(assigns(:wholesale_order))
  end

  test "should show wholesale_order" do
    get :show, id: @wholesale_order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wholesale_order
    assert_response :success
  end

  test "should update wholesale_order" do
    put :update, id: @wholesale_order, wholesale_order: { reseller_id: @wholesale_order.reseller_id, shipping_address_id: @wholesale_order.shipping_address_id, status: @wholesale_order.status }
    assert_redirected_to wholesale_order_path(assigns(:wholesale_order))
  end

  test "should destroy wholesale_order" do
    assert_difference('WholesaleOrder.count', -1) do
      delete :destroy, id: @wholesale_order
    end

    assert_redirected_to wholesale_orders_path
  end
end
