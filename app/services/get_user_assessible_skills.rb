module GetUserAssessibleSkills
  module_function

  def call(current_user)
    skills = []
    current_user.roles.each do |role|
      if role[:name] == "assessor"
        skill_id = role[:resource_id].to_i
        skills << Skill.find(skill_id) unless role[:resource_type] != "Skill"
      end
    end
    skills
  end
end
