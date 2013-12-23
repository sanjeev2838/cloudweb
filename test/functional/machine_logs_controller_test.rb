require 'test_helper'

class MachineLogsControllerTest < ActionController::TestCase
  setup do
    @machine_log = machine_logs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:machine_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create machine_log" do
    assert_difference('MachineLog.count') do
      post :create, machine_log: { description: @machine_log.description }
    end

    assert_redirected_to machine_log_path(assigns(:machine_log))
  end

  test "should show machine_log" do
    get :show, id: @machine_log
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @machine_log
    assert_response :success
  end

  test "should update machine_log" do
    put :update, id: @machine_log, machine_log: { description: @machine_log.description }
    assert_redirected_to machine_log_path(assigns(:machine_log))
  end

  test "should destroy machine_log" do
    assert_difference('MachineLog.count', -1) do
      delete :destroy, id: @machine_log
    end

    assert_redirected_to machine_logs_path
  end
end
