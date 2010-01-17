require 'test_helper'

class GiversControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:givers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create giver" do
    assert_difference('Giver.count') do
      post :create, :giver => { }
    end

    assert_redirected_to giver_path(assigns(:giver))
  end

  test "should show giver" do
    get :show, :id => givers(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => givers(:one).to_param
    assert_response :success
  end

  test "should update giver" do
    put :update, :id => givers(:one).to_param, :giver => { }
    assert_redirected_to giver_path(assigns(:giver))
  end

  test "should destroy giver" do
    assert_difference('Giver.count', -1) do
      delete :destroy, :id => givers(:one).to_param
    end

    assert_redirected_to givers_path
  end
end
