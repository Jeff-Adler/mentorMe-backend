class AddMenteeNameToPosts < ActiveRecord::Migration[6.0]
    def change
      add_column :posts, :mentee_name, :string
    end
  end