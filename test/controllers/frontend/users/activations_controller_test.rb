require 'test_helper'

class Frontend::Users::ActivationsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

end
