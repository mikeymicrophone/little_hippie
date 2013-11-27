require 'test_helper'

class CouponCategoriesControllerTest < ActionController::TestCase
  setup do
    @coupon_category = coupon_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coupon_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coupon_category" do
    assert_difference('CouponCategory.count') do
      post :create, coupon_category: {  }
    end

    assert_redirected_to coupon_category_path(assigns(:coupon_category))
  end

  test "should show coupon_category" do
    get :show, id: @coupon_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coupon_category
    assert_response :success
  end

  test "should update coupon_category" do
    put :update, id: @coupon_category, coupon_category: {  }
    assert_redirected_to coupon_category_path(assigns(:coupon_category))
  end

  test "should destroy coupon_category" do
    assert_difference('CouponCategory.count', -1) do
      delete :destroy, id: @coupon_category
    end

    assert_redirected_to coupon_categories_path
  end
end
