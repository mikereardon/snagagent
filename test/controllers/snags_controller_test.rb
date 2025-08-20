require "test_helper"

class SnagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @snag = snags(:one)
  end

  test "should get index" do
    get snags_url
    assert_response :success
  end

  test "should get new" do
    get new_snag_url
    assert_response :success
  end

  test "should create snag" do
    assert_difference("Snag.count") do
      post snags_url, params: { snag: { created_by: @snag.created_by, description: @snag.description, location: @snag.location, project_id: @snag.project_id } }
    end

    assert_redirected_to snag_url(Snag.last)
  end

  test "should show snag" do
    get snag_url(@snag)
    assert_response :success
  end

  test "should get edit" do
    get edit_snag_url(@snag)
    assert_response :success
  end

  test "should update snag" do
    patch snag_url(@snag), params: { snag: { created_by: @snag.created_by, description: @snag.description, location: @snag.location, project_id: @snag.project_id } }
    assert_redirected_to snag_url(@snag)
  end

  test "should destroy snag" do
    assert_difference("Snag.count", -1) do
      delete snag_url(@snag)
    end

    assert_redirected_to snags_url
  end
end
