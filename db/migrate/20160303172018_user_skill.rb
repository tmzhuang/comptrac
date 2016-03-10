class UserSkill < ActiveRecord::Migration
  def change
    remove_index :user_skill, :user_id, :skill_id
    add_index :user_skill, [:user_id, :skill_id], unique: true
  end
end
