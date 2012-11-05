require 'test_helper'

class ContentPagesControllerTest < ActionController::TestCase
  setup do
    @content_page = content_pages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:content_pages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create content_page" do
    assert_difference('ContentPage.count') do
      post :create, content_page: {  }
    end

    assert_redirected_to content_page_path(assigns(:content_page))
  end

  test "should show content_page" do
    get :show, id: @content_page
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @content_page
    assert_response :success
  end

  test "should update content_page" do
    put :update, id: @content_page, content_page: {  }
    assert_redirected_to content_page_path(assigns(:content_page))
  end

  test "should destroy content_page" do
    assert_difference('ContentPage.count', -1) do
      delete :destroy, id: @content_page
    end

    assert_redirected_to content_pages_path
  end
end
