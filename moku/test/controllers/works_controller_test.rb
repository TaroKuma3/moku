require 'test_helper'

class WorksControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get works_show_url
    assert_response :success
  end

  test "should get new" do
    get works_new_url
    assert_response :success
  end

  test "should get index" do
    get works_index_url
    assert_response :success
  end

  test "should get for_public" do
    get works_for_public_url
    assert_response :success
  end

  test "should get edit" do
    get works_edit_url
    assert_response :success
  end

  test "should get check_delete" do
    get works_check_delete_url
    assert_response :success
  end

end
