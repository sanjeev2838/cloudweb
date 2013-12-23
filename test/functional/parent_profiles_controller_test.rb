require 'test_helper'

class ParentProfilesControllerTest < ActionController::TestCase
  setup do
    @parent_profile = parent_profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parent_profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create parent_profile" do
    assert_difference('ParentProfile.count') do
      post :create, parent_profile: { device_id: @parent_profile.device_id, device_type_id: @parent_profile.device_type_id, imei: @parent_profile.imei, token_id: @parent_profile.token_id }
    end

    assert_redirected_to parent_profile_path(assigns(:parent_profile))
  end

  test "should show parent_profile" do
    get :show, id: @parent_profile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @parent_profile
    assert_response :success
  end

  test "should update parent_profile" do
    put :update, id: @parent_profile, parent_profile: { device_id: @parent_profile.device_id, device_type_id: @parent_profile.device_type_id, imei: @parent_profile.imei, token_id: @parent_profile.token_id }
    assert_redirected_to parent_profile_path(assigns(:parent_profile))
  end

  test "should destroy parent_profile" do
    assert_difference('ParentProfile.count', -1) do
      delete :destroy, id: @parent_profile
    end

    assert_redirected_to parent_profiles_path
  end
end
