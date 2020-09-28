class AddMessageCreatedAtToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :message_created_at, :string
  end
end
