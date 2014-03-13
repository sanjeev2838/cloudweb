require 'test_helper'

class VaccineLanguagesControllerTest < ActionController::TestCase
  setup do
    @vaccine_language = vaccine_languages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vaccine_languages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vaccine_language" do
    assert_difference('VaccineLanguage.count') do
      post :create, vaccine_language: {  }
    end

    assert_redirected_to vaccine_language_path(assigns(:vaccine_language))
  end

  test "should show vaccine_language" do
    get :show, id: @vaccine_language
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vaccine_language
    assert_response :success
  end

  test "should update vaccine_language" do
    put :update, id: @vaccine_language, vaccine_language: {  }
    assert_redirected_to vaccine_language_path(assigns(:vaccine_language))
  end

  test "should destroy vaccine_language" do
    assert_difference('VaccineLanguage.count', -1) do
      delete :destroy, id: @vaccine_language
    end

    assert_redirected_to vaccine_languages_path
  end
end
