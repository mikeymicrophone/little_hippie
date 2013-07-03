require 'test_helper'

class CouponsControllerTest < ActionController::TestCase
  setup do
    @coupon = coupons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coupons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coupon" do
    assert_difference('Coupon.count') do
      post :create, coupon: { amount: @coupon.amount, code: @coupon.code, expiration_date: @coupon.expiration_date, lower_limit: @coupon.lower_limit, name: @coupon.name, percentage: @coupon.percentage, upper_limit: @coupon.upper_limit, valid_date: @coupon.valid_date }
    end

    assert_redirected_to coupon_path(assigns(:coupon))
  end

  test "should show coupon" do
    get :show, id: @coupon
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coupon
    assert_response :success
  end

  test "should update coupon" do
    put :update, id: @coupon, coupon: { amount: @coupon.amount, code: @coupon.code, expiration_date: @coupon.expiration_date, lower_limit: @coupon.lower_limit, name: @coupon.name, percentage: @coupon.percentage, upper_limit: @coupon.upper_limit, valid_date: @coupon.valid_date }
    assert_redirected_to coupon_path(assigns(:coupon))
  end

  test "should destroy coupon" do
    assert_difference('Coupon.count', -1) do
      delete :destroy, id: @coupon
    end

    assert_redirected_to coupons_path
  end
end
