require 'test_helper'

class ReceivedInventoriesControllerTest < ActionController::TestCase
  setup do
    @received_inventory = received_inventories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:received_inventories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create received_inventory" do
    assert_difference('ReceivedInventory.count') do
      post :create, received_inventory: { amount_cancelled: @received_inventory.amount_cancelled, amount_delayed: @received_inventory.amount_delayed, date_received: @received_inventory.date_received }
    end

    assert_redirected_to received_inventory_path(assigns(:received_inventory))
  end

  test "should show received_inventory" do
    get :show, id: @received_inventory
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @received_inventory
    assert_response :success
  end

  test "should update received_inventory" do
    put :update, id: @received_inventory, received_inventory: { amount_cancelled: @received_inventory.amount_cancelled, amount_delayed: @received_inventory.amount_delayed, date_received: @received_inventory.date_received }
    assert_redirected_to received_inventory_path(assigns(:received_inventory))
  end

  test "should destroy received_inventory" do
    assert_difference('ReceivedInventory.count', -1) do
      delete :destroy, id: @received_inventory
    end

    assert_redirected_to received_inventories_path
  end
end
