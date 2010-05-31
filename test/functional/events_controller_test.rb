require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index, {:item_id => 1, :id =>1}
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new, :item_id => 1
    assert_response :success
    assert_not_nil assigns( :event )
    assert_not_nil assigns( :calibrators )
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create,  :event => { :item_id => items( :one ),
        :cal_date =>events( :one ).cal_date,
        :calibrator_id => events(:one).calibrator_id,
        :certs => fixture_file_upload('/files/cat.jpg', 'image/jpg')
      }
    end
    assert_redirected_to item_events_path( :item_id => items(:one) )
    assert_not_nil assigns( :event )
    assert_not_nil assigns( :calibrators )
    assert_not_nil assigns( :item )
  end

  test "should not create event with wrong file type" do
    #@calibrators = Calibrator.find( :all )
    assert_no_difference('Event.count') do
      post :create,  :event => { :item_id => items( :one ),
        :cal_date =>events( :one ).cal_date,
        :calibrator_id => events(:one).calibrator_id,
        :certs => fixture_file_upload('/files/fail.txt', 'txt/plain')
      }
    end
    assert_response :success
  end

  test "should show event" do
    get :show, :id => events(:one).to_param, :item_id => events( :one ).item_id
    assert_response :success
    assert_not_nil assigns( :event )
  end

  test "should get edit" do
    get :edit,   :item_id => items( :one ).id, :id => events(:one).id, :event => {  }
    assert_response :success
    assert_not_nil assigns( :event )
    assert_not_nil assigns( :calibrators )
  end

  test "should update event" do
    put :update, :item_id => events( :one ).item_id, :id => events(:one).id,
      :event => { :item_id => items( :one ),
        :cal_date =>events( :one ).cal_date,
        :calibrator_id => events(:one).calibrator_id,
        :certs => fixture_file_upload('/files/cat.jpg', 'image/jpg')
      }
    assert_redirected_to item_events_path(assigns(:event))
    assert_not_nil assigns( :event )
    assert_not_nil assigns( :calibrators )
    assert_not_nil assigns( :item )
  end

  test "should not update event with wrong file type" do
    put :update, :item_id => events( :one ).item_id, :id => events(:one).id,
      :event => { :item_id => items( :one ),
        :cal_date =>events( :one ).cal_date,
        :calibrator_id => events(:one).calibrator_id,
        :certs => fixture_file_upload('/files/fail.txt', 'txt/plain')
      }
    assert_response :success
    #assert_errors_on :certs
  end


  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, :id => events(:one).to_param, :item_id => items( :one )
    end

    #assert_redirected_to events_path
  end

  test "should display return from cal" do
    get :return_from_cal, :item_id => items( :one ).id, :id => events(:one).id, :event => {  }
    assert_redirected_to edit_item_event_path( :item_id => items(:one), :id => events(:one).id )
  end

end
