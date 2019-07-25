require 'test_helper'

class AnnoucementsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get annoucements_index_url
    assert_response :success
  end

  test "should get show" do
    get annoucements_show_url
    assert_response :success
  end

  test "should get new" do
    get annoucements_new_url
    assert_response :success
  end

  test "should get create" do
    get annoucements_create_url
    assert_response :success
  end

  test "should get edit" do
    get annoucements_edit_url
    assert_response :success
  end

  test "should get update" do
    get annoucements_update_url
    assert_response :success
  end

  test "should get destroy" do
    get annoucements_destroy_url
    assert_response :success
  end

end
