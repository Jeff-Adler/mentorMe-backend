class Message < ApplicationRecord
  belongs_to :post
  belongs_to :user #ActiveRecord not setup to give User access to their messages. Functionality not required. 
end
