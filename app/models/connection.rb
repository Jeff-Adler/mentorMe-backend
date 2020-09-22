class Connection < ApplicationRecord
  belongs_to :mentee, class_name: :User 
  belongs_to :mentor, class_name: :User 
  has_one :post
end
