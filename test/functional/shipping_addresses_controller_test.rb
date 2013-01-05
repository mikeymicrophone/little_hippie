require 'test_helper'

class ShippingAddressesControllerTest < ActionController::TestCase
  setup do
    @shipping_address = shipping_addresses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shipping_addresses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shipping_address" do
    assert_difference('ShippingAddress.count') do
      post :create, shipping_address: { city: @shipping_address.city, country: @shipping_address.country, email: @shipping_address.email, first_name: @shipping_address.first_name, last_name: @shipping_address.last_name, phone: @shipping_address.phone, position: @shipping_address.position, state: @shipping_address.state, street2: @shipping_address.street2, street: @shipping_address.street, zip: @shipping_address.zip }
    end

    assert_redirected_to shipping_address_path(assigns(:shipping_address))
  end

  test "should show shipping_address" do
    get :show, id: @shipping_address
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shipping_address
    assert_response :success
  end

  test "should update shipping_address" do
    put :update, id: @shipping_address, shipping_address: { city: @shipping_address.city, country: @shipping_address.country, email: @shipping_address.email, first_name: @shipping_address.first_name, last_name: @shipping_address.last_name, phone: @shipping_address.phone, position: @shipping_address.position, state: @shipping_address.state, street2: @shipping_address.street2, street: @shipping_address.street, zip: @shipping_address.zip }
    assert_redirected_to shipping_address_path(assigns(:shipping_address))
  end

  test "should destroy shipping_address" do
    assert_difference('ShippingAddress.count', -1) do
      delete :destroy, id: @shipping_address
    end

    assert_redirected_to shipping_addresses_path
  end
end
