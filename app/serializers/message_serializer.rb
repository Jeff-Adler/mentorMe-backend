class MessageSerializer < ActiveModel::Serializer
  attributes :id, :text, :message_created_at
  has_one :post
  has_one :user
end
