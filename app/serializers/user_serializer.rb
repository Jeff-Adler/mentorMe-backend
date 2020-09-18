class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :birthdate, :gender, :avatar, :prof_q1, :prof_q2, :prof_q3, :karma
end
