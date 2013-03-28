require 'test_helper'

class ImagePositionTemplatesControllerTest < ActionController::TestCase
  setup do
    @image_position_template = image_position_templates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:image_position_templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create image_position_template" do
    assert_difference('ImagePositionTemplate.count') do
      post :create, image_position_template: { left: @image_position_template.left, name: @image_position_template.name, position: @image_position_template.position, scale: @image_position_template.scale, top: @image_position_template.top }
    end

    assert_redirected_to image_position_template_path(assigns(:image_position_template))
  end

  test "should show image_position_template" do
    get :show, id: @image_position_template
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @image_position_template
    assert_response :success
  end

  test "should update image_position_template" do
    put :update, id: @image_position_template, image_position_template: { left: @image_position_template.left, name: @image_position_template.name, position: @image_position_template.position, scale: @image_position_template.scale, top: @image_position_template.top }
    assert_redirected_to image_position_template_path(assigns(:image_position_template))
  end

  test "should destroy image_position_template" do
    assert_difference('ImagePositionTemplate.count', -1) do
      delete :destroy, id: @image_position_template
    end

    assert_redirected_to image_position_templates_path
  end
end
