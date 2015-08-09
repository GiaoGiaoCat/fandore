require 'test_helper'

class VerificationCodeTest < ActiveSupport::TestCase
  fixtures :verification_codes

  # test "the truth" do
  #   assert true
  # end

  test "verify code ip request times limit" do
    request_ip = "127.0.0.1"
    email_code = User::EmailVerificationCode.new(to: "email@gmail.com", last_ip: request_ip)
    assert_equal email_code.save, false

    mobile_code = User::MobileVerificationCode.new(to: "13932011427", last_ip: request_ip)
    assert_equal mobile_code.save, false
  end
end
