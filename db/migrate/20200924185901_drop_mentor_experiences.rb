class DropMentorExperiences < ActiveRecord::Migration[6.0]
  def up
    drop_table :mentor_experiences
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
