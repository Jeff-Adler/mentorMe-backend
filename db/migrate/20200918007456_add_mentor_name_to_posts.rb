class AddMentorNameToPosts < ActiveRecord::Migration[6.0]
    def change
      add_column :posts, :mentor_name, :string
    end
  end