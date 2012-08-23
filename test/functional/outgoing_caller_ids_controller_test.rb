require 'test_helper'

class OutgoingCallerIdsControllerTest < ActionController::TestCase
  setup do
    @outgoing_caller_id = outgoing_caller_ids(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outgoing_caller_ids)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outgoing_caller_id" do
    assert_difference('OutgoingCallerId.count') do
      post :create, outgoing_caller_id: @outgoing_caller_id.attributes
    end

    assert_redirected_to outgoing_caller_id_path(assigns(:outgoing_caller_id))
  end

  test "should show outgoing_caller_id" do
    get :show, id: @outgoing_caller_id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @outgoing_caller_id
    assert_response :success
  end

  test "should update outgoing_caller_id" do
    put :update, id: @outgoing_caller_id, outgoing_caller_id: @outgoing_caller_id.attributes
    assert_redirected_to outgoing_caller_id_path(assigns(:outgoing_caller_id))
  end

  test "should destroy outgoing_caller_id" do
    assert_difference('OutgoingCallerId.count', -1) do
      delete :destroy, id: @outgoing_caller_id
    end

    assert_redirected_to outgoing_caller_ids_path
  end
end
