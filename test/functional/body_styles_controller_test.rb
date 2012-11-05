require 'test_helper'

class BodyStylesControllerTest < ActionController::TestCase
  setup do
    @body_style = body_styles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:body_styles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create body_style" do
    assert_difference('BodyStyle.count') do
      post :create, body_style: { code: @body_style.code, name: @body_style.name }
    end

    assert_redirected_to body_style_path(assigns(:body_style))
  end

  test "should show body_style" do
    get :show, id: @body_style
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @body_style
    assert_response :success
  end

  test "should update body_style" do
    put :update, id: @body_style, body_style: { code: @body_style.code, name: @body_style.name }
    assert_redirected_to body_style_path(assigns(:body_style))
  end

  test "should destroy body_style" do
    assert_difference('BodyStyle.count', -1) do
      delete :destroy, id: @body_style
    end

    assert_redirected_to body_styles_path
  end
end
