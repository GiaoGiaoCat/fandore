class UsersProfileColums < ActiveRecord::Migration
  def up
    add_column :users, :avatar,   :string
    add_column :users, :name,     :string
    add_column :users, :gender,   :integer
    add_column :users, :birthday, :datetime
    add_column :users, :role,     :string
  end

  def down
    remove_column :users, :avatar
    remove_column :users, :name
    remove_column :users, :gender
    remove_column :users, :birthday
    remove_column :users, :role
  end
end
