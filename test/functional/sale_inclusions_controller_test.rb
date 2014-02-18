require 'test_helper'

class SaleInclusionsControllerTest < ActionController::TestCase
  setup do
    @sale_inclusion = sale_inclusions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sale_inclusions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sale_inclusion" do
    assert_difference('SaleInclusion.count') do
      post :create, sale_inclusion: { active: @sale_inclusion.active, begin_date: @sale_inclusion.begin_date, end_date: @sale_inclusion.end_date, inclusion_id: @sale_inclusion.inclusion_id, inclusion_type: @sale_inclusion.inclusion_type }
    end

    assert_redirected_to sale_inclusion_path(assigns(:sale_inclusion))
  end

  test "should show sale_inclusion" do
    get :show, id: @sale_inclusion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sale_inclusion
    assert_response :success
  end

  test "should update sale_inclusion" do
    put :update, id: @sale_inclusion, sale_inclusion: { active: @sale_inclusion.active, begin_date: @sale_inclusion.begin_date, end_date: @sale_inclusion.end_date, inclusion_id: @sale_inclusion.inclusion_id, inclusion_type: @sale_inclusion.inclusion_type }
    assert_redirected_to sale_inclusion_path(assigns(:sale_inclusion))
  end

  test "should destroy sale_inclusion" do
    assert_difference('SaleInclusion.count', -1) do
      delete :destroy, id: @sale_inclusion
    end

    assert_redirected_to sale_inclusions_path
  end
end
