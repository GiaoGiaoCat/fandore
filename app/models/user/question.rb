class User::Question < ActiveType::Object
  attribute :email, :string
  attribute :answer, :string

  class << self
    def is_answer(user, answer)
      user.profile.answer == answer
    end
  end
end