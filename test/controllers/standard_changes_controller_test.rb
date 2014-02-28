require 'test_helper'

class StandardChangesControllerTest < ActionController::TestCase
  setup do
    @standard_change = standard_changes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:standard_changes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create standard_change" do
    assert_difference('StandardChange.count') do
      post :create, standard_change: { committee: @standard_change.committee, overview: @standard_change.overview, solution: @standard_change.solution, status: @standard_change.status, status_details: @standard_change.status_details, string: @standard_change.string, title: @standard_change.title, type: @standard_change.type, version_id: @standard_change.version_id }
    end

    assert_redirected_to standard_change_path(assigns(:standard_change))
  end

  test "should show standard_change" do
    get :show, id: @standard_change
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @standard_change
    assert_response :success
  end

  test "should update standard_change" do
    patch :update, id: @standard_change, standard_change: { committee: @standard_change.committee, overview: @standard_change.overview, solution: @standard_change.solution, status: @standard_change.status, status_details: @standard_change.status_details, string: @standard_change.string, title: @standard_change.title, type: @standard_change.type, version_id: @standard_change.version_id }
    assert_redirected_to standard_change_path(assigns(:standard_change))
  end

  test "should destroy standard_change" do
    assert_difference('StandardChange.count', -1) do
      delete :destroy, id: @standard_change
    end

    assert_redirected_to standard_changes_path
  end
end
