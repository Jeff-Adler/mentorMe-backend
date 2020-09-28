namespace :app do
    desc "Create messages for all posts"
    task :message_creator => :environment do
        Post.all.each do |iteratedPost|
            if iteratedPost.connection.mentor.id == User.last.id 
                Message.create!(post_id:iteratedPost.id, text: "First message!", user_id:iteratedPost.connection.mentee.id, message_created_at:"2020-09-27T23:43:37.496Z")
            elsif iteratedPost.connection.mentee.id == User.last.id 
                Message.create!(post_id:iteratedPost.id, text: "First message!", user_id:iteratedPost.connection.mentor.id, message_created_at:"2020-09-27T23:43:37.496Z")
            end
        end
    end
end