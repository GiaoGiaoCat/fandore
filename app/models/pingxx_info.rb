class PingxxInfo < ActiveRecord::Base
  belongs_to :order

  validates_presence_of :order, :pingxx_id, :amount
  validates_uniqueness_of :pingxx_id

  def charge_retrieve
    Pingpp::Charge.retrieve(self.pingxx_id)
  end
end
