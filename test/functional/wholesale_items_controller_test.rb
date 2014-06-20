require 'test_helper'

class WholesaleItemsControllerTest < ActionController::TestCase
  setup do
    @wholesale_item = wholesale_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wholesale_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wholesale_item" do
    assert_difference('WholesaleItem.count') do
      post :create, wholesale_item: { garment_id: @wholesale_item.garment_id, quantity: @wholesale_item.quantity, wholesale_order_id: @wholesale_item.wholesale_order_id }
    end

    assert_redirected_to wholesale_item_path(assigns(:wholesale_item))
  end

  test "should show wholesale_item" do
    get :show, id: @wholesale_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wholesale_item
    assert_response :success
  end

  test "should update wholesale_item" do
    put :update, id: @wholesale_item, wholesale_item: { garment_id: @wholesale_item.garment_id, quantity: @wholesale_item.quantity, wholesale_order_id: @wholesale_item.wholesale_order_id }
    assert_redirected_to wholesale_item_path(assigns(:wholesale_item))
  end

  test "should destroy wholesale_item" do
    assert_difference('WholesaleItem.count', -1) do
      delete :destroy, id: @wholesale_item
    end

    assert_redirected_to wholesale_items_path
  end
end
