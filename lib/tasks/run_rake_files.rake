namespace :app do
    desc 'All'
    task all: [:pending_creator,:post_creator,:message_creator]

    desc "Create connection requests to User.last"
    task :pending_creator => :environment do
        MENTOR_TYPES = [
            "professional",
            "interpersonal",
            "self-improvement"
        ]

        User.all.each do |user|
            random_boolean = [true, false].sample
            random_boolean2 = [true, false].sample
            random_index = rand(0..2)
            if random_boolean == true
                Connection.create!(mentee_id: user.id, mentor_id: User.last.id, accepted: random_boolean2, mentor_type: MENTOR_TYPES[random_index] ) unless user.id == User.last.id 
            else
                Connection.create!(mentee_id: User.last.id, mentor_id: user.id, accepted: random_boolean2, mentor_type: MENTOR_TYPES[random_index]) unless user.id == User.last.id 
            end
        end
    end
  
    desc "Create posts for User.last"
    task :post_creator => :environment do
        Connection.all.each do |connection|
            if connection.post == nil
                Post.create!(connection_id: connection.id) 
            end
        end
    end

    desc "Create messages for all posts"
    task :message_creator => :environment do
        Post.all.each do |iteratedPost|
            if iteratedPost.connection.mentor.id == User.last.id && (iteratedPost.messages == nil || iteratedPost.messages == [])
                Message.create!(post_id:iteratedPost.id, text: "Hey!", user_id:iteratedPost.connection.mentee.id, message_created_at:"2020-09-27T23:43:37.496Z")
            elsif iteratedPost.connection.mentee.id == User.last.id && (iteratedPost.messages == nil || iteratedPost.messages == [])
                Message.create!(post_id:iteratedPost.id, text: "Hey!", user_id:iteratedPost.connection.mentor.id, message_created_at:"2020-09-27T23:43:37.496Z")
            end
        end
    end
  end