require 'test_helper'

class CategoryProductFeaturesControllerTest < ActionController::TestCase
  setup do
    @category_product_feature = category_product_features(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:category_product_features)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create category_product_feature" do
    assert_difference('CategoryProductFeature.count') do
      post :create, category_product_feature: { position: @category_product_feature.position }
    end

    assert_redirected_to category_product_feature_path(assigns(:category_product_feature))
  end

  test "should show category_product_feature" do
    get :show, id: @category_product_feature
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @category_product_feature
    assert_response :success
  end

  test "should update category_product_feature" do
    put :update, id: @category_product_feature, category_product_feature: { position: @category_product_feature.position }
    assert_redirected_to category_product_feature_path(assigns(:category_product_feature))
  end

  test "should destroy category_product_feature" do
    assert_difference('CategoryProductFeature.count', -1) do
      delete :destroy, id: @category_product_feature
    end

    assert_redirected_to category_product_features_path
  end
end
