class Connection < ApplicationRecord
  belongs_to :mentee, class_name: :User #, foreign_key: :user_id, optional: true
  belongs_to :mentor, class_name: :User #, foreign_key: :user_id, optional: true
end
