class RemoveMentorNameFromPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :mentor_name, :string
  end
end
