require 'test_helper'

class ListeMariagesControllerTest < ActionController::TestCase
  setup do
    @liste_mariage = liste_mariages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:liste_mariages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create liste_mariage" do
    assert_difference('ListeMariage.count') do
      post :create, liste_mariage: { article: @liste_mariage.article, taken: @liste_mariage.taken }
    end

    assert_redirected_to liste_mariage_path(assigns(:liste_mariage))
  end

  test "should show liste_mariage" do
    get :show, id: @liste_mariage
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @liste_mariage
    assert_response :success
  end

  test "should update liste_mariage" do
    put :update, id: @liste_mariage, liste_mariage: { article: @liste_mariage.article, taken: @liste_mariage.taken }
    assert_redirected_to liste_mariage_path(assigns(:liste_mariage))
  end

  test "should destroy liste_mariage" do
    assert_difference('ListeMariage.count', -1) do
      delete :destroy, id: @liste_mariage
    end

    assert_redirected_to liste_mariages_path
  end
end
