require 'test_helper'

class ChildBrewingPreferencesControllerTest < ActionController::TestCase
  setup do
    @child_brewing_preference = child_brewing_preferences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:child_brewing_preferences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create child_brewing_preference" do
    assert_difference('ChildBrewingPreference.count') do
      post :create, child_brewing_preference: { milk_qty: @child_brewing_preference.milk_qty, temperature: @child_brewing_preference.temperature }
    end

    assert_redirected_to child_brewing_preference_path(assigns(:child_brewing_preference))
  end

  test "should show child_brewing_preference" do
    get :show, id: @child_brewing_preference
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @child_brewing_preference
    assert_response :success
  end

  test "should update child_brewing_preference" do
    put :update, id: @child_brewing_preference, child_brewing_preference: { milk_qty: @child_brewing_preference.milk_qty, temperature: @child_brewing_preference.temperature }
    assert_redirected_to child_brewing_preference_path(assigns(:child_brewing_preference))
  end

  test "should destroy child_brewing_preference" do
    assert_difference('ChildBrewingPreference.count', -1) do
      delete :destroy, id: @child_brewing_preference
    end

    assert_redirected_to child_brewing_preferences_path
  end
end
