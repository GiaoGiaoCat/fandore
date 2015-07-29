class User::Address < ActiveRecord::Base
  # extends ...................................................................
  # includes ..................................................................
  # constants .................................................................
  self.table_name = 'addresses'
  # related macros ............................................................
  # relationships .............................................................
  belongs_to :user
  # validations ...............................................................
  validates :full_name, presence: true
  validates :mobile,
          presence: true,
          format: { with: /\A(13[0-9]|15[0-9]|18[7-8])[0-9]{8}\z/ }
  validates :address_detail, presence: true
  validates :province, presence: true
  validates :city, presence: true
  validates :district, presence: true
  # callbacks .................................................................
  after_create :first_address


  # scopes ....................................................................
  # other macros (like devise's) ..............................................
  # class methods .............................................................
  # public instance methods ...................................................
  # protected instance methods ................................................
  def province_name
    ChinaCity.get(self.province)  
  end

  def city_name
    ChinaCity.get(self.city)
  end

  def district_name
    ChinaCity.get(self.district)
  end

  def default_address
    self.user.addresses.each do |address|
      address.update(is_default: false)
    end
    self.update(is_default: true)
  end

  def first_address
    self.update(is_default: true) if self.user.addresses.count == 1
    default_address if self.is_default
  end

  # private instance methods ..................................................
end
