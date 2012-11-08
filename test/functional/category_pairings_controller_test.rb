require 'test_helper'

class CategoryPairingsControllerTest < ActionController::TestCase
  setup do
    @category_pairing = category_pairings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:category_pairings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create category_pairing" do
    assert_difference('CategoryPairing.count') do
      post :create, category_pairing: { position: @category_pairing.position }
    end

    assert_redirected_to category_pairing_path(assigns(:category_pairing))
  end

  test "should show category_pairing" do
    get :show, id: @category_pairing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @category_pairing
    assert_response :success
  end

  test "should update category_pairing" do
    put :update, id: @category_pairing, category_pairing: { position: @category_pairing.position }
    assert_redirected_to category_pairing_path(assigns(:category_pairing))
  end

  test "should destroy category_pairing" do
    assert_difference('CategoryPairing.count', -1) do
      delete :destroy, id: @category_pairing
    end

    assert_redirected_to category_pairings_path
  end
end
