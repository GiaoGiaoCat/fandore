class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, limit: 100
      t.string :mobile, limit: 50
      t.string :password_digest, limit: 80
      t.boolean :is_email_actived, null: false, default: false

      t.timestamps null: false
    end
  end
end
