require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item" do
    assert_difference('Item.count') do
      post :create, :item => { :description => 'test',
      :org_sn => 'test_sn', :pn => 'id10t', :cal_cycle_days => 365,
      :picture => fixture_file_upload('/files/cat.jpg', 'image/jpg')
      }
    end
    assert_redirected_to item_path(assigns(:item))
  end

  test "should not create item on wrong picture type" do
    assert_no_difference('Item.count') do
      post :create, :item => { :description => 'test',
      :org_sn => 'test_sn', :pn => 'id10t', :cal_cycle_days => 365,
      :picture => fixture_file_upload('/files/fail.txt', 'text/plain')
      }
    end
    assert_response :success
  end

  test "should show item" do
    get :show, :id => items(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => items(:one).to_param
    assert_response :success
  end

  test "should update item" do
    put :update, :id => items(:one).id, :item => {:description => 'test',
      :org_sn => 'test_sn', :pn => 'id10t', :cal_cycle_days => 365,
      :picture => fixture_file_upload('/files/cat.jpg', 'image/jpeg')},
      :html => {:multipart => true }


    assert_redirected_to item_path(assigns(:item))
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete :destroy, :id => items(:one).to_param
    end

    assert_redirected_to items_path
  end
end
