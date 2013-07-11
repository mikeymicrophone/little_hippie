require 'test_helper'

class MetaDescriptionsControllerTest < ActionController::TestCase
  setup do
    @meta_description = meta_descriptions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:meta_descriptions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create meta_description" do
    assert_difference('MetaDescription.count') do
      post :create, meta_description: { action: @meta_description.action, controller: @meta_description.controller, current: @meta_description.current, description: @meta_description.description, keywords: @meta_description.keywords, og_image: @meta_description.og_image, resource_id: @meta_description.resource_id }
    end

    assert_redirected_to meta_description_path(assigns(:meta_description))
  end

  test "should show meta_description" do
    get :show, id: @meta_description
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @meta_description
    assert_response :success
  end

  test "should update meta_description" do
    put :update, id: @meta_description, meta_description: { action: @meta_description.action, controller: @meta_description.controller, current: @meta_description.current, description: @meta_description.description, keywords: @meta_description.keywords, og_image: @meta_description.og_image, resource_id: @meta_description.resource_id }
    assert_redirected_to meta_description_path(assigns(:meta_description))
  end

  test "should destroy meta_description" do
    assert_difference('MetaDescription.count', -1) do
      delete :destroy, id: @meta_description
    end

    assert_redirected_to meta_descriptions_path
  end
end
