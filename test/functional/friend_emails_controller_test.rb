require 'test_helper'

class FriendEmailsControllerTest < ActionController::TestCase
  setup do
    @friend_email = friend_emails(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:friend_emails)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create friend_email" do
    assert_difference('FriendEmail.count') do
      post :create, friend_email: { email: @friend_email.email, message: @friend_email.message }
    end

    assert_redirected_to friend_email_path(assigns(:friend_email))
  end

  test "should show friend_email" do
    get :show, id: @friend_email
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @friend_email
    assert_response :success
  end

  test "should update friend_email" do
    put :update, id: @friend_email, friend_email: { email: @friend_email.email, message: @friend_email.message }
    assert_redirected_to friend_email_path(assigns(:friend_email))
  end

  test "should destroy friend_email" do
    assert_difference('FriendEmail.count', -1) do
      delete :destroy, id: @friend_email
    end

    assert_redirected_to friend_emails_path
  end
end
