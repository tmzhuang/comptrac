class CreateUserSkills < ActiveRecord::Migration
  def change
    create_table :user_skills do |t|
      t.integer :competence , :default => 1, null:false

      t.timestamps null: false
    end
  end
end
