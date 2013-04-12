require 'test_helper'

class BillingAddressesControllerTest < ActionController::TestCase
  setup do
    @billing_address = billing_addresses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:billing_addresses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create billing_address" do
    assert_difference('BillingAddress.count') do
      post :create, billing_address: { city: @billing_address.city, email: @billing_address.email, first_name: @billing_address.first_name, hidden: @billing_address.hidden, last_name: @billing_address.last_name, phone: @billing_address.phone, position: @billing_address.position, street2: @billing_address.street2, street: @billing_address.street, zip: @billing_address.zip }
    end

    assert_redirected_to billing_address_path(assigns(:billing_address))
  end

  test "should show billing_address" do
    get :show, id: @billing_address
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @billing_address
    assert_response :success
  end

  test "should update billing_address" do
    put :update, id: @billing_address, billing_address: { city: @billing_address.city, email: @billing_address.email, first_name: @billing_address.first_name, hidden: @billing_address.hidden, last_name: @billing_address.last_name, phone: @billing_address.phone, position: @billing_address.position, street2: @billing_address.street2, street: @billing_address.street, zip: @billing_address.zip }
    assert_redirected_to billing_address_path(assigns(:billing_address))
  end

  test "should destroy billing_address" do
    assert_difference('BillingAddress.count', -1) do
      delete :destroy, id: @billing_address
    end

    assert_redirected_to billing_addresses_path
  end
end
