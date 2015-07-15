require 'test_helper'

class PlacesControllerTest < ActionController::TestCase
  test "should get radio" do
    get :radio
    assert_response :success
  end

end
