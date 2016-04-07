class Skill < ActiveRecord::Base
  include Searchable

  has_many :user_skills, dependent: :destroy
  has_many :users, through: :user_skills
  resourcify
end
