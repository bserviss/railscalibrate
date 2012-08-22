require 'test_helper'

class ExternalDocsControllerTest < ActionController::TestCase
  setup do
    @external_doc = external_docs(:one)
  end

  test "should get index" do
    get :index, :item_id => 1
    assert_response :success
    assert_not_nil assigns(:external_docs)
  end

  test "should get new" do
    get :new, :item_id => 1
    assert_response :success
  end

  test "should create external_doc" do
    assert_difference('ExternalDoc.count') do
      post :create, :external_doc => { :item_id => items( :one ), #@external_doc.attributes
        :id => @external_doc.to_param,
        :description => external_docs( :one ).description,
        :doc => fixture_file_upload('/files/cat.jpg', 'image/jpg') }
    end
    assert_redirected_to item_external_docs_path( :item_id => items(:one) )    
    assert_not_nil assigns(:external_doc)
  end

  test "should not create external_doc without a description" do
    assert_no_difference('ExternalDoc.count') do
      post :create, :external_doc => { :item_id => items( :one ), #@external_doc.attributes
        :id => @external_doc.to_param,
        :doc => fixture_file_upload('/files/cat.jpg', 'image/jpg') }
    end
    assert_response :success
  end

  test "should not create external_doc with wrong file type" do
    assert_no_difference('ExternalDoc.count') do
      post :create, :external_doc => { :item_id => items( :one ), #@external_doc.attributes
        :id => @external_doc.to_param,
        :doc => fixture_file_upload('/files/cat.jpg', 'image/jpg') }
    end
    assert_response :success
  end
 
  
  test "should show external_doc" do
    get :show, {:item_id => 1,:id => @external_doc.to_param}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {:item_id => 1, :id => @external_doc.to_param}
    assert_response :success
  end

  test "should update external_doc" do
    put :update, :item_id => external_docs( :one ).item_id, #:id => @external_doc.to_param, :external_doc => @external_doc.attributes}
    :id => external_docs(:one).id,
    :external_doc => {:item_id => items( :one ),
      :description => external_docs(:one).description,
      :doc => fixture_file_upload('/files/cat.jpg', 'image/jpg')
      }
    assert_redirected_to item_external_docs_path(assigns(:external_doc))
  end

  test "should not update external_doc with no description" do
    put :update, :item_id => external_docs( :one ).item_id, #:id => @external_doc.to_param, :external_doc => @external_doc.attributes}
    :id => external_docs(:one).id,
    :external_doc => {:item_id => items( :one ),
      :doc => fixture_file_upload('/files/cat.jpg', 'image/jpg')
      }
    assert_redirected_to item_external_docs_path( :item_id => items(:one) )
  end


  test "should destroy external_doc" do
    assert_difference('ExternalDoc.count', -1) do
      delete :destroy, :id => external_docs(:one).to_param, :item_id => items( :one )
    end

    assert_redirected_to item_external_docs_path( :item_id => items(:one) )
  end

end
