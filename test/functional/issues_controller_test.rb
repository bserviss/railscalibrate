require 'test_helper'

class IssuesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index, {:item_id => 1, :id =>1}
    assert_response :success
    assert_not_nil assigns(:issues)
  end

  test "should get new" do
    get :new, :item_id => 1
    assert_response :success
  end 

  test "should create issue" do
    assert_difference('Issue.count') do
      post :create,  :issue => { :item_id => items( :one ) }
    end
    assert_redirected_to item_issues_path( :item_id => items(:one) )
      #assigns(:event))
  end

  test "should show issue" do
    get :show, :id => issues(:one).to_param, :item_id => issues( :one ).item_id
    assert_response :success
  end

  test "should get edit" do
    get :edit,   :item_id => items( :one ).id, :id => issues(:one).id, :issue => {  }
    assert_response :success
  end

  test "should update issue" do
    put :update, :item_id => issues( :one ).item_id, :id => issues(:one).id,
      :issue => { :item_id => items( :one ), :description => issues(:one).description }
    assert_redirected_to item_issues_path(assigns(:issue))
  end

  test "should destroy issue" do
    assert_difference('Issue.count', -1) do
      delete :destroy, :id => issues(:one).to_param, :item_id => items( :one )
    end
  end


end
