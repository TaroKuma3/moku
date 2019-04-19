require 'test_helper'

class MokuTypeControllerTest < ActionDispatch::IntegrationTest
  test "should get check_delete" do
    get moku_type_check_delete_url
    assert_response :success
  end

  test "should get edit" do
    get moku_type_edit_url
    assert_response :success
  end

  test "should get index" do
    get moku_type_index_url
    assert_response :success
  end

  test "should get new" do
    get moku_type_new_url
    assert_response :success
  end

  test "should get show" do
    get moku_type_show_url
    assert_response :success
  end

end
