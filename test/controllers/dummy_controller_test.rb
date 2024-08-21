require "test_helper"

class DummyControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dummy_index_url
    assert_response :success
  end
end
