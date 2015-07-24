class User::Profile < ActiveType::Record[User]
  attribute :name,     :string
  attribute :avatar,   :string
  attribute :gender,   :integer
  attribute :birthday, :datetime
end
