require 'test_helper'

class ManufacturersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get manufacturers_new_url
    assert_response :success
  end

end
