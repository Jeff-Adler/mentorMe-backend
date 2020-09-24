class AddExperiencesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :professional, :boolean
    add_column :users, :interpersonal, :boolean
    add_column :users, :self_improvement, :boolean
  end
end
