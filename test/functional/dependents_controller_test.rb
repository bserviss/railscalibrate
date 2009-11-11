require 'test_helper'

class DependentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dependents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dependent" do
    assert_difference('Dependent.count') do
      post :create, :dependent => { }
    end

    assert_redirected_to dependent_path(assigns(:dependent))
  end

  test "should show dependent" do
    get :show, :id => dependents(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => dependents(:one).to_param
    assert_response :success
  end

  test "should update dependent" do
    put :update, :id => dependents(:one).to_param, :dependent => { }
    assert_redirected_to dependent_path(assigns(:dependent))
  end

  test "should destroy dependent" do
    assert_difference('Dependent.count', -1) do
      delete :destroy, :id => dependents(:one).to_param
    end

    assert_redirected_to dependents_path
  end
end
