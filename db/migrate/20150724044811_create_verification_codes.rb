class CreateVerificationCodes < ActiveRecord::Migration
  def change
    create_table :verification_codes do |t|
      t.references :user, index: true
      t.string :code
      t.string :to, limit: 100, index: true
      t.string :type, limit: 100, index: true
      t.string :last_ip

      t.timestamps null: false
    end
  end
end
