class AddAnswerToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :answer, :string
  end
end
