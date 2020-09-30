class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :first_name, :last_name, :birthdate, :gender, :avatar, :professional,:interpersonal,:self_improvement, :description
end
