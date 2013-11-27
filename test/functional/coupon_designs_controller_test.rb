require 'test_helper'

class CouponDesignsControllerTest < ActionController::TestCase
  setup do
    @coupon_design = coupon_designs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coupon_designs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coupon_design" do
    assert_difference('CouponDesign.count') do
      post :create, coupon_design: {  }
    end

    assert_redirected_to coupon_design_path(assigns(:coupon_design))
  end

  test "should show coupon_design" do
    get :show, id: @coupon_design
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coupon_design
    assert_response :success
  end

  test "should update coupon_design" do
    put :update, id: @coupon_design, coupon_design: {  }
    assert_redirected_to coupon_design_path(assigns(:coupon_design))
  end

  test "should destroy coupon_design" do
    assert_difference('CouponDesign.count', -1) do
      delete :destroy, id: @coupon_design
    end

    assert_redirected_to coupon_designs_path
  end
end
