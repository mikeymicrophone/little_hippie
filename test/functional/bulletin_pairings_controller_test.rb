require 'test_helper'

class BulletinPairingsControllerTest < ActionController::TestCase
  setup do
    @bulletin_pairing = bulletin_pairings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bulletin_pairings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bulletin_pairing" do
    assert_difference('BulletinPairing.count') do
      post :create, bulletin_pairing: { position: @bulletin_pairing.position }
    end

    assert_redirected_to bulletin_pairing_path(assigns(:bulletin_pairing))
  end

  test "should show bulletin_pairing" do
    get :show, id: @bulletin_pairing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bulletin_pairing
    assert_response :success
  end

  test "should update bulletin_pairing" do
    put :update, id: @bulletin_pairing, bulletin_pairing: { position: @bulletin_pairing.position }
    assert_redirected_to bulletin_pairing_path(assigns(:bulletin_pairing))
  end

  test "should destroy bulletin_pairing" do
    assert_difference('BulletinPairing.count', -1) do
      delete :destroy, id: @bulletin_pairing
    end

    assert_redirected_to bulletin_pairings_path
  end
end
