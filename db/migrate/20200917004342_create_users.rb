class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :birthdate
      t.string :gender
      t.string :avatar
      t.string :prof_q1
      t.string :prof_q2
      t.string :prof_q3
      t.integer :karma

      t.timestamps
    end
  end
end
