require 'test_helper'

class BodyStyleProductFeaturesControllerTest < ActionController::TestCase
  setup do
    @body_style_product_feature = body_style_product_features(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:body_style_product_features)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create body_style_product_feature" do
    assert_difference('BodyStyleProductFeature.count') do
      post :create, body_style_product_feature: { position: @body_style_product_feature.position }
    end

    assert_redirected_to body_style_product_feature_path(assigns(:body_style_product_feature))
  end

  test "should show body_style_product_feature" do
    get :show, id: @body_style_product_feature
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @body_style_product_feature
    assert_response :success
  end

  test "should update body_style_product_feature" do
    put :update, id: @body_style_product_feature, body_style_product_feature: { position: @body_style_product_feature.position }
    assert_redirected_to body_style_product_feature_path(assigns(:body_style_product_feature))
  end

  test "should destroy body_style_product_feature" do
    assert_difference('BodyStyleProductFeature.count', -1) do
      delete :destroy, id: @body_style_product_feature
    end

    assert_redirected_to body_style_product_features_path
  end
end
