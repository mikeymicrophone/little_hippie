require 'test_helper'

class CouponProductsControllerTest < ActionController::TestCase
  setup do
    @coupon_product = coupon_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coupon_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coupon_product" do
    assert_difference('CouponProduct.count') do
      post :create, coupon_product: {  }
    end

    assert_redirected_to coupon_product_path(assigns(:coupon_product))
  end

  test "should show coupon_product" do
    get :show, id: @coupon_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coupon_product
    assert_response :success
  end

  test "should update coupon_product" do
    put :update, id: @coupon_product, coupon_product: {  }
    assert_redirected_to coupon_product_path(assigns(:coupon_product))
  end

  test "should destroy coupon_product" do
    assert_difference('CouponProduct.count', -1) do
      delete :destroy, id: @coupon_product
    end

    assert_redirected_to coupon_products_path
  end
end
