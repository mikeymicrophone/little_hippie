require 'test_helper'

class DeliveryAddressesControllerTest < ActionController::TestCase
  setup do
    @delivery_address = delivery_addresses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:delivery_addresses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create delivery_address" do
    assert_difference('DeliveryAddress.count') do
      post :create, delivery_address: { city: @delivery_address.city, email: @delivery_address.email, first_name: @delivery_address.first_name, hidden: @delivery_address.hidden, last_name: @delivery_address.last_name, phone: @delivery_address.phone, position: @delivery_address.position, street2: @delivery_address.street2, street: @delivery_address.street, zip: @delivery_address.zip }
    end

    assert_redirected_to delivery_address_path(assigns(:delivery_address))
  end

  test "should show delivery_address" do
    get :show, id: @delivery_address
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @delivery_address
    assert_response :success
  end

  test "should update delivery_address" do
    put :update, id: @delivery_address, delivery_address: { city: @delivery_address.city, email: @delivery_address.email, first_name: @delivery_address.first_name, hidden: @delivery_address.hidden, last_name: @delivery_address.last_name, phone: @delivery_address.phone, position: @delivery_address.position, street2: @delivery_address.street2, street: @delivery_address.street, zip: @delivery_address.zip }
    assert_redirected_to delivery_address_path(assigns(:delivery_address))
  end

  test "should destroy delivery_address" do
    assert_difference('DeliveryAddress.count', -1) do
      delete :destroy, id: @delivery_address
    end

    assert_redirected_to delivery_addresses_path
  end
end
