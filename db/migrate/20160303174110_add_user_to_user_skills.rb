class AddUserToUserSkills < ActiveRecord::Migration
  def change
    add_reference :user_skills, :user, index: true, foreign_key: true
  end
end
