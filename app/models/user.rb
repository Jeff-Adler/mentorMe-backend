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
            self.is_younger?(user) unless user.id == self.id || user.birthdate == nil
        end
    end

    def is_younger?(user)
        Date.parse(user.birthdate) > Date.parse(self.birthdate)
    end

    def pendings
        connections = Connection.all.select do |connection| 
            connection.mentor_id == self.id
        end

        if connections != []
            pendings = connections.map do |connection|
                connection.mentee
            end
        else
            nil
        end
    end
end
