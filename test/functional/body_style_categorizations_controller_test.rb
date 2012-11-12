require 'test_helper'

class BodyStyleCategorizationsControllerTest < ActionController::TestCase
  setup do
    @body_style_categorization = body_style_categorizations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:body_style_categorizations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create body_style_categorization" do
    assert_difference('BodyStyleCategorization.count') do
      post :create, body_style_categorization: { active: @body_style_categorization.active, position: @body_style_categorization.position }
    end

    assert_redirected_to body_style_categorization_path(assigns(:body_style_categorization))
  end

  test "should show body_style_categorization" do
    get :show, id: @body_style_categorization
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @body_style_categorization
    assert_response :success
  end

  test "should update body_style_categorization" do
    put :update, id: @body_style_categorization, body_style_categorization: { active: @body_style_categorization.active, position: @body_style_categorization.position }
    assert_redirected_to body_style_categorization_path(assigns(:body_style_categorization))
  end

  test "should destroy body_style_categorization" do
    assert_difference('BodyStyleCategorization.count', -1) do
      delete :destroy, id: @body_style_categorization
    end

    assert_redirected_to body_style_categorizations_path
  end
end
