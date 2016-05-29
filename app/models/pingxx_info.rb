class PingxxInfo < ActiveRecord::Base
  belongs_to :order

  validates_presence_of :order, :pingxx_id, :amount
end
