require 'test_helper'

class UsedTimesControllerTest < ActionController::TestCase
  setup do
    @used_time = used_times(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:used_times)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create used_time" do
    assert_difference('UsedTime.count') do
      post :create, used_time: { otdel_id: @used_time.otdel_id, seconds: @used_time.seconds, task_id: @used_time.task_id, user_id: @used_time.user_id, ut_type_id: @used_time.ut_type_id }
    end

    assert_redirected_to used_time_path(assigns(:used_time))
  end

  test "should show used_time" do
    get :show, id: @used_time
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @used_time
    assert_response :success
  end

  test "should update used_time" do
    patch :update, id: @used_time, used_time: { otdel_id: @used_time.otdel_id, seconds: @used_time.seconds, task_id: @used_time.task_id, user_id: @used_time.user_id, ut_type_id: @used_time.ut_type_id }
    assert_redirected_to used_time_path(assigns(:used_time))
  end

  test "should destroy used_time" do
    assert_difference('UsedTime.count', -1) do
      delete :destroy, id: @used_time
    end

    assert_redirected_to used_times_path
  end
end
