class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string      :title, limit: 50, default: ""
      t.text        :comment
      t.references  :commentable, polymorphic: true
      t.references  :user, index: true
      t.string      :role, defaul: "comments"
      t.text        :pictures

      t.timestamps
    end

    add_index :comments, :commentable_type
    add_index :comments, :commentable_id
  end
end
