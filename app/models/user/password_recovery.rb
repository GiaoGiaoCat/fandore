class User::PasswordRecovery < ActiveType::Record[User]

  class << self
    def get_otp_code(mobile)
      user = User.find_by(mobile: mobile)
      if user
        code = user.otp_code(time: Time.now + 1200)  
      else
        false
      end
    end  
    def verify(mobile, code)
      user = User.find_by(mobile: mobile)
      user && user.authenticate_otp(code, drift: 1200) 
    end
  end
end


