class User < ActiveRecord::Base
  has_many :user_skills, dependent: :destroy
  has_many :skills, through: :user_skills

  def add_skill(skill)
    user_skills.create(skill_id: skill.id)
  end

  def remove_skill(skill)
    user_skills.find_by(skill_id: skill.id).destroy
  end

  def has_skill?(skill)
    skils.include?(skill)
  end
end
