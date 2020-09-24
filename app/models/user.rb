class User < ApplicationRecord
    has_secure_password
    validates :username, uniqueness: { case_sensitive: false }
    validates :username, :password, length: { in: 6..20 }

    has_many :mentor_connections, class_name: :Connection, foreign_key: :mentee_id
    has_many :mentors, through: :mentor_connections, foreign_key: :mentor_id

    has_many :mentee_connections, class_name: :Connection, foreign_key: :mentor_id
    has_many :mentees, through: :mentee_connections, foreign_key: :mentee_id

    def calculate_karma
        if self.mentee_connections.length != 0
            self.mentor_connections.length / self.mentee_connections.length
        else
            0
        end
    end
    
    # def eligible_mentors
    #     eligible_mentors = User.all.select do |user|
    #         self.is_younger?(user) unless user.id == self.id || user.birthdate == nil
    #     end

    #     filtered_eligible_mentors = eligible_mentors.select do |user|
    #         Connection.find_by(mentee: self, mentor: user) == nil
    #     end
    # end

    def eligible_mentors(mentor_type)
        #filters out self
        all_other_users = self.filter_self(User.all)
        #filters out users who are already connected to self
        non_connected_users = self.filter_connected_users(all_other_users)
        #filters out users who are younger than self
        older_users = self.compare_ages(non_connected_users)
        #finds all users whose experiences matches mentor_type
        eligible_mentors = self.match_experiences(older_users,mentor_type)
    end

    def filter_self(users)
        users.select do |user|
            user.id != self.id
        end
    end

    def filter_connected_users(users)
        users.select do |user|
            Connection.find_by(mentee: self, mentor: user) == nil
        end
    end

    def compare_ages(users)
        users.select do |user|
            self.is_younger?(user) unless user.birthdate == nil
        end
    end

    def is_younger?(user)
        Date.parse(user.birthdate) < Date.parse(self.birthdate)
    end

    def match_experiences(users,mentor_type)
        users.select do |user|
            user[mentor_type] == true
        end
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
