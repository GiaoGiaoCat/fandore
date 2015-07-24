class CreateVerificationCodes < ActiveRecord::Migration
  def change
    create_table :verification_codes do |t|
      t.references :user, index: true
      t.string :code, limit: 24
      t.string :mobile, limit: 24

      t.timestamps null: false
    end
  end
end
