array!(@user_skills) do |user_skill|
  json.extract! user_skill, :id, :competence
  json.url user_skill_url(user_skill, format: :json)
end
