require 'test_helper'

class PaintsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get paints_index_url
    assert_response :success
  end

  test "should get new" do
    get paints_new_url
    assert_response :success
  end

  test "should get edit" do
    get paints_edit_url
    assert_response :success
  end

end
