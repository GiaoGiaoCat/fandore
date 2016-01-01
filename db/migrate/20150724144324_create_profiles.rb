class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true, foreign_key: true

      t.string    :avatar
      t.string    :name, limit: 40
      t.date      :birthday
      t.integer   :gender

      t.string    :partner_name, limit: 40
      t.date      :partner_birthday
      t.string    :partner_email, limit: 100
      t.string    :partner_mobile, limit: 50

      t.string    :question
      t.string    :answer

      t.timestamps null: false
    end
  end
end
