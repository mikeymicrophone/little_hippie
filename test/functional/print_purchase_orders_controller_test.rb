require 'test_helper'

class PrintPurchaseOrdersControllerTest < ActionController::TestCase
  setup do
    @print_purchase_order = print_purchase_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:print_purchase_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create print_purchase_order" do
    assert_difference('PrintPurchaseOrder.count') do
      post :create, print_purchase_order: {  }
    end

    assert_redirected_to print_purchase_order_path(assigns(:print_purchase_order))
  end

  test "should show print_purchase_order" do
    get :show, id: @print_purchase_order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @print_purchase_order
    assert_response :success
  end

  test "should update print_purchase_order" do
    put :update, id: @print_purchase_order, print_purchase_order: {  }
    assert_redirected_to print_purchase_order_path(assigns(:print_purchase_order))
  end

  test "should destroy print_purchase_order" do
    assert_difference('PrintPurchaseOrder.count', -1) do
      delete :destroy, id: @print_purchase_order
    end

    assert_redirected_to print_purchase_orders_path
  end
end
