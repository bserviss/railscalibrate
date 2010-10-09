require 'test_helper'

class ExternalDocsControllerTest < ActionController::TestCase
  setup do
    @external_doc = external_docs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:external_docs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create external_doc" do
    assert_difference('ExternalDoc.count') do
      post :create, :external_doc => @external_doc.attributes
    end

    assert_redirected_to external_doc_path(assigns(:external_doc))
  end

  test "should show external_doc" do
    get :show, :id => @external_doc.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @external_doc.to_param
    assert_response :success
  end

  test "should update external_doc" do
    put :update, :id => @external_doc.to_param, :external_doc => @external_doc.attributes
    assert_redirected_to external_doc_path(assigns(:external_doc))
  end

  test "should destroy external_doc" do
    assert_difference('ExternalDoc.count', -1) do
      delete :destroy, :id => @external_doc.to_param
    end

    assert_redirected_to external_docs_path
  end
end
