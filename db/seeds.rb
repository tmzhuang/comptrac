# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
Skill.create(name: "ruby", category: "Language")
Skill.create(name: "Java", category: "Language")
Skill.create(name: "javascript", category: "Language")
Skill.create(name: "perl", category: "Language")
Skill.create(name: "Haskell", category: "Language")
Skill.create(name: "LISP", category: "Language")
Skill.create(name: "c", category: "Language")

Skill.create(name: "git", category: "Version Control")
Skill.create(name: "ClearCase", category: "Version Control")
Skill.create(name: "CVS", category: "Version Control")

Skill.create(name: "postgres", category: "Database")
Skill.create(name: "sqlite", category: "Database")
Skill.create(name: "MySQL", category: "Database")
