require 'test_helper'

class CategoryImagesControllerTest < ActionController::TestCase
  setup do
    @category_image = category_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:category_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create category_image" do
    assert_difference('CategoryImage.count') do
      post :create, category_image: { display_end: @category_image.display_end, display_start: @category_image.display_start, image: @category_image.image }
    end

    assert_redirected_to category_image_path(assigns(:category_image))
  end

  test "should show category_image" do
    get :show, id: @category_image
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @category_image
    assert_response :success
  end

  test "should update category_image" do
    put :update, id: @category_image, category_image: { display_end: @category_image.display_end, display_start: @category_image.display_start, image: @category_image.image }
    assert_redirected_to category_image_path(assigns(:category_image))
  end

  test "should destroy category_image" do
    assert_difference('CategoryImage.count', -1) do
      delete :destroy, id: @category_image
    end

    assert_redirected_to category_images_path
  end
end
