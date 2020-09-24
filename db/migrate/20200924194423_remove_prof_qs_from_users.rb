class RemoveProfQsFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :prof_q1, :string
    remove_column :users, :prof_q2, :string
    remove_column :users, :prof_q3, :string
  end
end
