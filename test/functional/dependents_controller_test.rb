require 'test_helper'

class DependentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index, {:item_id => 1, :id =>1}
    assert_response :success
    assert_not_nil assigns(:dependents)
  end

  test "should get new" do
    get :new, :item_id => items( :one ).id
    assert_response :success
  end

  test "should create dependent" do
    assert_difference('Dependent.count') do
      post :create, :dependent => {:item_id => items( :one ) }
    end

    #assert_redirected_to dependent_path(assigns(:dependent))
  end

  test "should show dependent" do
    get :show,    :item_id => items( :one ).id, :id => dependents(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit,   :item_id => items( :one ).id, :id => dependents(:one).to_param
    assert_response :success
  end

  test "should update dependent" do
    put :update,  :item_id => events( :one ).item_id,:id => dependents(:one).to_param, :dependent => { :item_id => items( :one ) }
    #assert_redirected_to item_dependents_path(assigns(:dependent))
  end

  test "should destroy dependent" do
    assert_difference('Dependent.count', -1) do
      delete :destroy, :item_id => events(:one).to_param, :id => dependents(:one).to_param
    end

    #assert_redirected_to dependents_path
  end
end
