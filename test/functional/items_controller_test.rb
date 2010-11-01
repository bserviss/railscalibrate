require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns( :items )
    #update yaml to include one in_cal
    #assert_not_nil assigns( :due_cal )
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

  test "should not update item with incorrect file type" do
    #test the else in the update method
    put :update, :id => items(:one).id, :item => {:description => 'test',
      :org_sn => 'test_sn', :pn => 'id10t', :cal_cycle_days => 365,
      :picture => fixture_file_upload('/files/fail.txt', 'text/plain')},
      :html => {:multipart => true }
    #assert_equal  false, f.is_valid?
    assert_response :success #back to the edit view
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete :destroy, :id => items(:one).to_param
    end

    assert_redirected_to items_path
  end

  test "should display inactive items" do
    get :show_inactive
    assert_response :success
    assert_not_nil assigns( :items )
    assert_equal 2, @controller.instance_variable_get('@items').size , "Should be 2 items inactive"

  end

  test "should display 30 day items" do
    get :show_thirty_days
    assert_response :success
    assert_not_nil assigns( :display_group )
    display_group = @controller.instance_variable_get('@display_group')
    assert_equal  1, display_group.size , "Should be one item due in thirty days"
  end

  test "should display 60 day items" do
    get :show_sixty_days
    assert_response :success
    assert_not_nil assigns( :display_group )
    #assert_equal  1, @controller.instance_variable_get('@display_group').size , "Should be one item due in 60 days"
  end

  test "should show items in cal" do
    get :show_in_cal
    assert_response :success
    assert_not_nil assigns( :items )
    assert_equal  1, @controller.instance_variable_get('@items').size , "Should be one item in cal"
  end


  test "should display all items" do
    get :show_all_items
    assert_response :success
    assert_not_nil assigns( :display_group )
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
  end

  test "should show remote_search with sn" do
    get :search_remote, :sn => 'MyString',:description => ''
    assert_response :success
    assert_not_nil assigns( :search_results )
  end

  test "should show issue_remote" do
    get :issue_remote
    assert_response :success
    assert_not_nil assigns( :issues )
  end

  test "should show dependent_remote" do
    get :dependent_remote
    assert_response :success
    assert_not_nil assigns( :dependents )
  end

  test "should display show_all_events" do
    get :show_all_events
    assert_response :success
    assert_not_nil assigns( :events )
  end 
  
end
