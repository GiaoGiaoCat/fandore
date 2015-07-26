class AddIndexToVerificationCodes < ActiveRecord::Migration
  def change
    add_index :verification_codes, :mobile, :unique => true
  end
end
