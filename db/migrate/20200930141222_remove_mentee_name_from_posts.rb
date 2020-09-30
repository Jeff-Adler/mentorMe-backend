class RemoveMenteeNameFromPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :mentee_name, :string
  end
end
