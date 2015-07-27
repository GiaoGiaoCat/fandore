require 'test_helper'

class Frontend::Users::PasswordsControllerTest < ActionController::TestCase
  test "should get edit" do
    get :edit
    assert_response :success
  end

end
