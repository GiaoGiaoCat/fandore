class AddIpColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :registe_ip, :string
    add_column :users, :last_sign_in_address, :string
    add_column :users, :last_sign_in_ip, :string
    add_column :users, :last_sign_in_at, :datetime
  end
end
