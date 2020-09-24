class CreateMenteeExperiences < ActiveRecord::Migration[6.0]
  def change
    create_table :mentee_experiences do |t|
      t.boolean :high_school
      t.boolean :college
      t.boolean :early_career
      t.boolean :personal_relationships
      t.boolean :romantic_relationships
      t.boolean :passions
      t.boolean :self_confidence
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
