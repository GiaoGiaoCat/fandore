class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string    :email, limit: 100
      t.string    :mobile, limit: 50
      t.string    :password_digest, limit: 80

      t.string    :otp_secret_key
      t.integer   :otp_counter

      t.datetime  :activated_at
      t.integer   :role, default: 1

      t.integer   :sign_in_count, default: 0, null: false
      t.datetime  :current_sign_in_at
      t.string    :current_sign_in_ip
      t.datetime  :last_sign_in_at
      t.string    :last_sign_in_ip
      t.datetime  :last_failed_sign_in_at
      t.integer   :failed_sign_in_count, default: 0, null: false

      t.timestamps null: false
    end
  end
end
