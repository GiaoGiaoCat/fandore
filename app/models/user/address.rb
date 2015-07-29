class User::Address < ActiveRecord::Base
  # extends ...................................................................
  # includes ..................................................................
  # constants .................................................................
  self.table_name = 'addresses'
  # related macros ............................................................
  # relationships .............................................................
  belongs_to :user
  # validations ...............................................................
  validates_presence_of :user_id, :name, :address, :province, :city, :district
  validates :mobile,
            presence: true,
            format: { with: /\A(13[0-9]|15[0-9]|18[7-8])[0-9]{8}\z/ }
  # callbacks .................................................................
  after_create :set_default_address
  # scopes ....................................................................
  # other macros (like devise's) ..............................................
  # class methods .............................................................
  # public instance methods ...................................................
  def province_name
    ChinaCity.get(province)
  end

  def city_name
    ChinaCity.get(city)
  end

  def district_name
    ChinaCity.get(district)
  end

  def default_address
    self.user.addresses.each do |address|
      address.update(is_default: false)
    end
    self.update(is_default: true)
  end
  # protected instance methods ................................................
  # private instance methods ..................................................
  private

  def set_default_address
    self.update(is_default: true) if self.user.addresses.count == 1
    default_address if self.is_default
  end
end
