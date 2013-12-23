require 'test_helper'

class ChildStatsControllerTest < ActionController::TestCase
  setup do
    @child_stat = child_stats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:child_stats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create child_stat" do
    assert_difference('ChildStat.count') do
      post :create, child_stat: { diaper_count: @child_stat.diaper_count, food: @child_stat.food, height: @child_stat.height, weight: @child_stat.weight }
    end

    assert_redirected_to child_stat_path(assigns(:child_stat))
  end

  test "should show child_stat" do
    get :show, id: @child_stat
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @child_stat
    assert_response :success
  end

  test "should update child_stat" do
    put :update, id: @child_stat, child_stat: { diaper_count: @child_stat.diaper_count, food: @child_stat.food, height: @child_stat.height, weight: @child_stat.weight }
    assert_redirected_to child_stat_path(assigns(:child_stat))
  end

  test "should destroy child_stat" do
    assert_difference('ChildStat.count', -1) do
      delete :destroy, id: @child_stat
    end

    assert_redirected_to child_stats_path
  end
end
