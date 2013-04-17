require 'test_helper'

class InvitationsControllerTest < ActionController::TestCase
  setup do
    @invitation = invitations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:invitations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create invitation" do
    assert_difference('Invitation.count') do
      post :create, invitation: { approved_at: @invitation.approved_at, email: @invitation.email, invited_by_email: @invitation.invited_by_email, invited_by_name: @invitation.invited_by_name, name: @invitation.name, note: @invitation.note }
    end

    assert_redirected_to invitation_path(assigns(:invitation))
  end

  test "should show invitation" do
    get :show, id: @invitation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @invitation
    assert_response :success
  end

  test "should update invitation" do
    put :update, id: @invitation, invitation: { approved_at: @invitation.approved_at, email: @invitation.email, invited_by_email: @invitation.invited_by_email, invited_by_name: @invitation.invited_by_name, name: @invitation.name, note: @invitation.note }
    assert_redirected_to invitation_path(assigns(:invitation))
  end

  test "should destroy invitation" do
    assert_difference('Invitation.count', -1) do
      delete :destroy, id: @invitation
    end

    assert_redirected_to invitations_path
  end
end
