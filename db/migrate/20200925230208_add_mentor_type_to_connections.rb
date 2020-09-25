class AddMentorTypeToConnections < ActiveRecord::Migration[6.0]
  def change
    add_column :connections, :mentor_type, :string
  end
end
