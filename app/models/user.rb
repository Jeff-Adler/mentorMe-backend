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

    def pending_connections 
        Connection.all.select do |connection| 
            connection.mentor_id == self.id && connection.accepted == false
        end
    end

    def pending_users
        connections = self.pending_connections

        if connections != []
            pendings = connections.map do |connection|
                connection.mentee
            end
        else
            nil
        end
    end

    def accepted_connections(user_type)
        if user_type == "mentor"
            Connection.all.select do |connection|
                connection.mentor_id == self.id && connection.accepted == true
            end
        elsif user_type == "mentee"
            Connection.all.select do |connection|
                connection.mentee_id == self.id && connection.accepted == true
            end
        end
    end

    def posts(user_type)
        connections = self.accepted_connections(user_type)

        if connections != nil
            Post.map_posts_from_connections(connections)
        end
    end
end
