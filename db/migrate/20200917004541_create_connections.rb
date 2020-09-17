class CreateConnections < ActiveRecord::Migration[6.0]
  def change
    create_table :connections do |t|
      t.references :mentee, foreign_key: { to_table: 'users' }
      t.references :mentor, foreign_key: { to_table: 'users' }
      t.boolean :accepted, default: false

      t.timestamps
    end
  end
end
