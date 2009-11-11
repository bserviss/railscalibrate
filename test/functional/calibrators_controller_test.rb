require 'test_helper'

class CalibratorsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:calibrators)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create calibrator" do
    assert_difference('Calibrator.count') do
      post :create, :calibrator => { :a_name => calibrators(:one).a_name}
    end

    assert_redirected_to calibrator_path(assigns(:calibrator))
  end

  test "should show calibrator" do
    get :show, :id => calibrators(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => calibrators(:one).to_param
    assert_response :success
  end

  test "should update calibrator" do
    put :update, :id => calibrators(:one).to_param, :calibrator => { }
    assert_redirected_to calibrator_path(assigns(:calibrator))
  end

  test "should destroy calibrator" do
    assert_difference('Calibrator.count', -1) do
      delete :destroy, :id => calibrators(:one).to_param
    end

    assert_redirected_to calibrators_path
  end
end
