require 'test_helper'

class UtTypesControllerTest < ActionController::TestCase
  setup do
    @ut_type = ut_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ut_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ut_type" do
    assert_difference('UtType.count') do
      post :create, ut_type: { name: @ut_type.name }
    end

    assert_redirected_to ut_type_path(assigns(:ut_type))
  end

  test "should show ut_type" do
    get :show, id: @ut_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ut_type
    assert_response :success
  end

  test "should update ut_type" do
    patch :update, id: @ut_type, ut_type: { name: @ut_type.name }
    assert_redirected_to ut_type_path(assigns(:ut_type))
  end

  test "should destroy ut_type" do
    assert_difference('UtType.count', -1) do
      delete :destroy, id: @ut_type
    end

    assert_redirected_to ut_types_path
  end
end
