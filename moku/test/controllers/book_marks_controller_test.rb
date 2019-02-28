require 'test_helper'

class BookMarksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get book_marks_index_url
    assert_response :success
  end

end
