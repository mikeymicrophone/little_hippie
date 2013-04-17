require 'test_helper'

class StashedInventoriesControllerTest < ActionController::TestCase
  setup do
    @stashed_inventory = stashed_inventories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stashed_inventories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stashed_inventory" do
    assert_difference('StashedInventory.count') do
      post :create, stashed_inventory: {  }
    end

    assert_redirected_to stashed_inventory_path(assigns(:stashed_inventory))
  end

  test "should show stashed_inventory" do
    get :show, id: @stashed_inventory
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stashed_inventory
    assert_response :success
  end

  test "should update stashed_inventory" do
    put :update, id: @stashed_inventory, stashed_inventory: {  }
    assert_redirected_to stashed_inventory_path(assigns(:stashed_inventory))
  end

  test "should destroy stashed_inventory" do
    assert_difference('StashedInventory.count', -1) do
      delete :destroy, id: @stashed_inventory
    end

    assert_redirected_to stashed_inventories_path
  end
end
