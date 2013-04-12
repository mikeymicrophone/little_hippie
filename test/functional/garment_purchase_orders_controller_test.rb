require 'test_helper'

class GarmentPurchaseOrdersControllerTest < ActionController::TestCase
  setup do
    @garment_purchase_order = garment_purchase_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:garment_purchase_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create garment_purchase_order" do
    assert_difference('GarmentPurchaseOrder.count') do
      post :create, garment_purchase_order: {  }
    end

    assert_redirected_to garment_purchase_order_path(assigns(:garment_purchase_order))
  end

  test "should show garment_purchase_order" do
    get :show, id: @garment_purchase_order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @garment_purchase_order
    assert_response :success
  end

  test "should update garment_purchase_order" do
    put :update, id: @garment_purchase_order, garment_purchase_order: {  }
    assert_redirected_to garment_purchase_order_path(assigns(:garment_purchase_order))
  end

  test "should destroy garment_purchase_order" do
    assert_difference('GarmentPurchaseOrder.count', -1) do
      delete :destroy, id: @garment_purchase_order
    end

    assert_redirected_to garment_purchase_orders_path
  end
end
