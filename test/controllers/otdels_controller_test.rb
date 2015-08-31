require 'test_helper'

class OtdelsControllerTest < ActionController::TestCase
  setup do
    @otdel = otdels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:otdels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create otdel" do
    assert_difference('Otdel.count') do
      post :create, otdel: { name: @otdel.name }
    end

    assert_redirected_to otdel_path(assigns(:otdel))
  end

  test "should show otdel" do
    get :show, id: @otdel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @otdel
    assert_response :success
  end

  test "should update otdel" do
    patch :update, id: @otdel, otdel: { name: @otdel.name }
    assert_redirected_to otdel_path(assigns(:otdel))
  end

  test "should destroy otdel" do
    assert_difference('Otdel.count', -1) do
      delete :destroy, id: @otdel
    end

    assert_redirected_to otdels_path
  end
end
