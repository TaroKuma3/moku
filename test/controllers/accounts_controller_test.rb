require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get accounts_edit_url
    assert_response :success
  end

  test "should get check_delete" do
    get accounts_check_delete_url
    assert_response :success
  end

end
