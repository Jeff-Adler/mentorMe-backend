class AddExperiencesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :professional, :boolean, default: false
    add_column :users, :interpersonal, :boolean, default: false
    add_column :users, :self_improvement, :boolean, default: false
  end
end
