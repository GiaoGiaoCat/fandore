class AddQuestionToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :question, :string
  end
end
