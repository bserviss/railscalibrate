require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns( :in_cal )
    #update yaml to include one in_cal
    assert_not_nil assigns( :due_cal )
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns( :item )
  end

  test "should create item" do
    assert_difference('Item.count') do
      post :create, :item => { :description => 'test',
      :org_sn => 'test_sn', :pn => 'id10t', :cal_cycle_days => 365,
      :picture => fixture_file_upload('/files/cat.jpg', 'image/jpg')
      } #nice cat picture!
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
    assert_not_nil assigns( :item )
    assert_not_nil assigns( :issues )
    assert_not_nil assigns( :dependents )
  end

  test "should get edit" do
    get :edit, :id => items(:one).to_param
    assert_response :success
    assert_not_nil assigns( :item )
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

  test "should display inactive items" do
    get :remote, :token => 'IA'
    assert_response :success
    assert_not_nil assigns( :display_group )
    assert_template :partial => '_group'
  end

  test "should display 30 day items" do
    get :remote, :token => '30'
    assert_response :success
    assert_not_nil assigns( :display_group )
    assert_template :partial => '_group'

  end

  test "should display 60 day items" do
    get :remote, :token => 'sixty_r'
    assert_response :success
    assert_not_nil assigns( :display_group )
    assert_template :partial => '_group'
  end

  test "should display over 60 day items" do
    get :remote, :token => 'over_r'
    assert_response :success
    assert_not_nil assigns( :display_group )
    assert_template :partial => '_group'
  end

  test "should display all items" do
    get :remote, :token => 'all_r'
    assert_response :success
    assert_not_nil assigns( :display_group )
    assert_template :partial => '_group'
  end

  test "should display printable due_cal" do
    get :printable_due_cal
    assert_response :success
    assert_not_nil assigns( :due_cal )
  end

  test "should display printable in_cal" do
    get :printable_in_cal
    assert_response :success
    assert_not_nil assigns( :in_cal )
  end

  test "should display printable_thirty_days" do
    get :printable_thirty_days
    assert_response :success
    assert_not_nil assigns( :thirty_days )
  end

  test "should show remote_search with description" do
    get :search_remote, :description => 'Due_cal'
    assert_response :success
    assert_not_nil assigns( :search_results )
    assert_template 'search_remote'
  end

  test "should show remote_search with sn" do
    get :search_remote, :sn => 'MyString',:description => ''
    assert_response :success
    assert_not_nil assigns( :search_results )
    assert_template 'search_remote'
  end

  test "should show issue_remote" do
    get :issue_remote
    assert_response :success
    assert_not_nil assigns( :issues )
    assert_template :partial => '_issues'
  end

  test "should show dependent_remote" do
    get :dependent_remote
    assert_response :success
    assert_not_nil assigns( :dependents )
    assert_template :partial => '_dependents'
  end

end
