require 'test_helper'

class MailingListRegistrationsControllerTest < ActionController::TestCase
  setup do
    @mailing_list_registration = mailing_list_registrations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mailing_list_registrations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mailing_list_registration" do
    assert_difference('MailingListRegistration.count') do
      post :create, mailing_list_registration: { email: @mailing_list_registration.email, first_name: @mailing_list_registration.first_name, last_name: @mailing_list_registration.last_name }
    end

    assert_redirected_to mailing_list_registration_path(assigns(:mailing_list_registration))
  end

  test "should show mailing_list_registration" do
    get :show, id: @mailing_list_registration
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mailing_list_registration
    assert_response :success
  end

  test "should update mailing_list_registration" do
    put :update, id: @mailing_list_registration, mailing_list_registration: { email: @mailing_list_registration.email, first_name: @mailing_list_registration.first_name, last_name: @mailing_list_registration.last_name }
    assert_redirected_to mailing_list_registration_path(assigns(:mailing_list_registration))
  end

  test "should destroy mailing_list_registration" do
    assert_difference('MailingListRegistration.count', -1) do
      delete :destroy, id: @mailing_list_registration
    end

    assert_redirected_to mailing_list_registrations_path
  end
end
