class RemoveAdvertiseToPromotions < ActiveRecord::Migration
  def change
    remove_column :promotions, :advertise
  end
end
