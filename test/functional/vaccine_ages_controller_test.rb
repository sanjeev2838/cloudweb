require 'test_helper'

class VaccineAgesControllerTest < ActionController::TestCase
  setup do
    @vaccine_age = vaccine_ages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vaccine_ages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vaccine_age" do
    assert_difference('VaccineAge.count') do
      post :create, vaccine_age: {  }
    end

    assert_redirected_to vaccine_age_path(assigns(:vaccine_age))
  end

  test "should show vaccine_age" do
    get :show, id: @vaccine_age
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vaccine_age
    assert_response :success
  end

  test "should update vaccine_age" do
    put :update, id: @vaccine_age, vaccine_age: {  }
    assert_redirected_to vaccine_age_path(assigns(:vaccine_age))
  end

  test "should destroy vaccine_age" do
    assert_difference('VaccineAge.count', -1) do
      delete :destroy, id: @vaccine_age
    end

    assert_redirected_to vaccine_ages_path
  end
end
