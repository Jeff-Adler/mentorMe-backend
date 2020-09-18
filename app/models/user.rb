class User < ApplicationRecord
    has_secure_password
    validates :username, uniqueness: { case_sensitive: false }
    validates :username, :password, length: { in: 6..20 }

    has_many :mentor_connections, class_name: :Connection, foreign_key: :mentee_id
    has_many :mentors, through: :mentor_connections, foreign_key: :mentor_id

    has_many :mentee_connections, class_name: :Connection, foreign_key: :mentor_id
    has_many :mentees, through: :mentee_connections, foreign_key: :mentee_id
end
