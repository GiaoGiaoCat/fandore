module Fandore
  class Regex
    PHONE_REGEX = /\A(13[0-9]|15[0-9]|18[0-9]|17[0-9])[0-9]{8}\z/.freeze
    EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.freeze
  end
end
