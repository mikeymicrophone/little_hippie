require 'test_helper'

class DesignFeaturesControllerTest < ActionController::TestCase
  setup do
    @design_feature = design_features(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:design_features)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create design_feature" do
    assert_difference('DesignFeature.count') do
      post :create, design_feature: { active_from: @design_feature.active_from, active_until: @design_feature.active_until, business_manager_id: @design_feature.business_manager_id, position: @design_feature.position }
    end

    assert_redirected_to design_feature_path(assigns(:design_feature))
  end

  test "should show design_feature" do
    get :show, id: @design_feature
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @design_feature
    assert_response :success
  end

  test "should update design_feature" do
    put :update, id: @design_feature, design_feature: { active_from: @design_feature.active_from, active_until: @design_feature.active_until, business_manager_id: @design_feature.business_manager_id, position: @design_feature.position }
    assert_redirected_to design_feature_path(assigns(:design_feature))
  end

  test "should destroy design_feature" do
    assert_difference('DesignFeature.count', -1) do
      delete :destroy, id: @design_feature
    end

    assert_redirected_to design_features_path
  end
end
