require 'test_helper'

class BodyStyleSizesControllerTest < ActionController::TestCase
  setup do
    @body_style_size = body_style_sizes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:body_style_sizes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create body_style_size" do
    assert_difference('BodyStyleSize.count') do
      post :create, body_style_size: {  }
    end

    assert_redirected_to body_style_size_path(assigns(:body_style_size))
  end

  test "should show body_style_size" do
    get :show, id: @body_style_size
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @body_style_size
    assert_response :success
  end

  test "should update body_style_size" do
    put :update, id: @body_style_size, body_style_size: {  }
    assert_redirected_to body_style_size_path(assigns(:body_style_size))
  end

  test "should destroy body_style_size" do
    assert_difference('BodyStyleSize.count', -1) do
      delete :destroy, id: @body_style_size
    end

    assert_redirected_to body_style_sizes_path
  end
end
