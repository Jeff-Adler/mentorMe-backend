class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :first_name, :last_name, :birthdate, :gender, :avatar, :karma,:professional,:interpersonal,:self_improvement
end
