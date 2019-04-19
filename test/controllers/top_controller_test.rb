require 'test_helper'

class TopControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get top_index_url
    assert_response :success
  end

  test "should get about" do
    get top_about_url
    assert_response :success
  end

end
