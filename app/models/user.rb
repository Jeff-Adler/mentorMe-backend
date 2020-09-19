class User < ApplicationRecord
    has_secure_password
    validates :username, uniqueness: { case_sensitive: false }
    validates :username, :password, length: { in: 6..20 }

    has_many :mentor_connections, class_name: :Connection, foreign_key: :mentee_id
    has_many :mentors, through: :mentor_connections, foreign_key: :mentor_id

    has_many :mentee_connections, class_name: :Connection, foreign_key: :mentor_id
    has_many :mentees, through: :mentee_connections, foreign_key: :mentee_id


    def eligible_mentors
        eligible_mentors = User.all.select do |user|
            self.is_younger?(user) unless user.id == self.id
        end
    end

    def is_younger?(user)
        Date.parse(user.birthdate) > Date.parse(self.birthdate)
    end
end
