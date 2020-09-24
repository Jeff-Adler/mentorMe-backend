class User < ApplicationRecord
    has_secure_password
    validates :username, uniqueness: { case_sensitive: false }
    validates :username, :password, length: { in: 6..20 }

    has_one :mentee_experience
    has_one :mentor_experience

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
    
    def eligible_mentors
        eligible_mentors = User.all.select do |user|
            self.is_younger?(user) unless user.id == self.id || user.birthdate == nil
        end

        filtered_eligible_mentors = eligible_mentors.select do |user|
            Connection.find_by(mentee: self, mentor: user) == nil
        end
    end

    def is_younger?(user)
        Date.parse(user.birthdate) < Date.parse(self.birthdate)
    end

    # def eligible_mentors
    #     #Eliminates users who self is already connected with
    #     not_connected_users = self.filter_connected_users(User.all)
    #     #Filters non-connected users by users older than self
    #     mentors_by_age = self.compare_ages(not_connected_users)
    #     #Filters older users by matching experiences
    #     mentors_by_age_and_experience = self.compare_experiences(mentors_by_age)
    # end

    # def filter_connected_users(users)
    #     users.select do |user|
    #         Connection.find_by(mentee: self, mentor: user) == nil
    #     end
    # end

    # def compare_ages(users)
    #     users.select do |user|
    #         self.is_younger?(user) unless user.id == self.id || user.birthdate == nil
    #     end
    # end

    # def compare_experiences(users)
    #     users.select do |user|
    #         self.compare_experience(user,experience1)
    #         self.compare_experience(user,experience2)
    #         self.compare_experience(user,experience3)
    #         self.compare_experience(user,experience4)
    #     end
    # end

    # def compare_experience(user,experience)
    #     self.mentee_experience[experience] == true && user.mentor_experience[experience] == true
    # end

    # def matched_experiences(user)
    #     matched_experiences = {
    #         high_school:false,
    #         college:false,
    #         early_career:false,
    #         personal_relationships:false,
    #         romantic_relationships:false,
    #         passions:false,
    #         self_confidence:false,
    #     }
    #     matched_experiences.each do |experience,boolean|
    #          matched_experiences[experience] = self.compare_experience(user,experience)
    #     end
    #     matched_experiences
    # end

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
