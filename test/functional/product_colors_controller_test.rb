require 'test_helper'

class ProductColorsControllerTest < ActionController::TestCase
  setup do
    @product_color = product_colors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_colors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_color" do
    assert_difference('ProductColor.count') do
      post :create, product_color: {  }
    end

    assert_redirected_to product_color_path(assigns(:product_color))
  end

  test "should show product_color" do
    get :show, id: @product_color
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_color
    assert_response :success
  end

  test "should update product_color" do
    put :update, id: @product_color, product_color: {  }
    assert_redirected_to product_color_path(assigns(:product_color))
  end

  test "should destroy product_color" do
    assert_difference('ProductColor.count', -1) do
      delete :destroy, id: @product_color
    end

    assert_redirected_to product_colors_path
  end
end
