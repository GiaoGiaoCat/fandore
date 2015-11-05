class User::Address < ActiveRecord::Base
  # table name
  self.table_name = 'addresses'
  # extends ...................................................................
  # includes ..................................................................
  # constants .................................................................
  # related macros ............................................................
  # relationships .............................................................
  belongs_to :user
  # validations ...............................................................
  # TODO：前端无法做好地址传递，暂时取消验证省市区参数
  # validates_presence_of :user_id, :name, :address, :province, :city, :district
  validates_presence_of :user_id, :name, :address
  # validates :province, :city, :district, numericality: true

  validates :mobile,
            presence: true,
            format: { with: Fandore::Regex::PHONE_REGEX }

  # callbacks .................................................................
  after_save :set_default_address
  # scopes ....................................................................
  # other macros (like devise's) ..............................................
  # class methods .............................................................
  # public instance methods ...................................................
  def province_name
    ChinaCity.get(province) rescue ''
  end

  def city_name
    ChinaCity.get(city) rescue ''
  end

  def district_name
    ChinaCity.get(district) rescue ''
  end

  def cancel_default!
    update_column(:is_default, false)
  end
  # protected instance methods ................................................
  # private instance methods ..................................................
  private

  def set_default_address
    if is_default || user.addresses.count == 1
      user.addresses.each(&:cancel_default!)
      update_column(:is_default, true)
    end
  end
end
