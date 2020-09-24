class DropMenteeExperiences < ActiveRecord::Migration[6.0]
  def up
    drop_table :mentee_experiences
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
