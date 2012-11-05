require 'test_helper'

class ProductManagersControllerTest < ActionController::TestCase
  setup do
    @product_manager = product_managers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_managers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_manager" do
    assert_difference('ProductManager.count') do
      post :create, product_manager: {  }
    end

    assert_redirected_to product_manager_path(assigns(:product_manager))
  end

  test "should show product_manager" do
    get :show, id: @product_manager
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_manager
    assert_response :success
  end

  test "should update product_manager" do
    put :update, id: @product_manager, product_manager: {  }
    assert_redirected_to product_manager_path(assigns(:product_manager))
  end

  test "should destroy product_manager" do
    assert_difference('ProductManager.count', -1) do
      delete :destroy, id: @product_manager
    end

    assert_redirected_to product_managers_path
  end
end
