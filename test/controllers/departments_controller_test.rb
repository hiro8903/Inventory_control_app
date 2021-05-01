require 'test_helper'

class DepartmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get departments_new_url
    assert_response :success
  end

end
