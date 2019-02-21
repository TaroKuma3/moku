require 'test_helper'

class MokusControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mokus_index_url
    assert_response :success
  end

  test "should get new" do
    get mokus_new_url
    assert_response :success
  end

  test "should get show" do
    get mokus_show_url
    assert_response :success
  end

  test "should get edit" do
    get mokus_edit_url
    assert_response :success
  end

  test "should get check_delete" do
    get mokus_check_delete_url
    assert_response :success
  end

end
