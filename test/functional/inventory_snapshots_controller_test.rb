require 'test_helper'

class InventorySnapshotsControllerTest < ActionController::TestCase
  setup do
    @inventory_snapshot = inventory_snapshots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inventory_snapshots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inventory_snapshot" do
    assert_difference('InventorySnapshot.count') do
      post :create, inventory_snapshot: { current_amount: @inventory_snapshot.current_amount, initial_amount: @inventory_snapshot.initial_amount }
    end

    assert_redirected_to inventory_snapshot_path(assigns(:inventory_snapshot))
  end

  test "should show inventory_snapshot" do
    get :show, id: @inventory_snapshot
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inventory_snapshot
    assert_response :success
  end

  test "should update inventory_snapshot" do
    put :update, id: @inventory_snapshot, inventory_snapshot: { current_amount: @inventory_snapshot.current_amount, initial_amount: @inventory_snapshot.initial_amount }
    assert_redirected_to inventory_snapshot_path(assigns(:inventory_snapshot))
  end

  test "should destroy inventory_snapshot" do
    assert_difference('InventorySnapshot.count', -1) do
      delete :destroy, id: @inventory_snapshot
    end

    assert_redirected_to inventory_snapshots_path
  end
end
