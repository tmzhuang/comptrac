class AddSkillToUserSkills < ActiveRecord::Migration
  def change
    add_reference :user_skills, :skill, index: true, foreign_key: true
  end
end
