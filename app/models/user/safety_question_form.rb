class User::SafetyQuestionForm < ActiveType::Record[User::Profile]

  attribute :question, :string
  attribute :answer, :string

  validates :question, presence: true, length: { minimum: 20 }, on: :update
  validates :answer, presence: true, length: { minimum: 2 }, on: :update
  
  class << self

  end
end



