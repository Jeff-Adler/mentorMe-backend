namespace :app do
    desc "Create messages for all posts"
    task :message_creator => :environment do
        Post.all.each do |iteratedPost|
            if iteratedPost.connection.mentor.id == User.last.id 
                Message.create!(post_id:iteratedPost.id, text: "First message!", user_id:iteratedPost.connection.mentee.id)
            elsif iteratedPost.connection.mentee.id == User.last.id 
                Message.create!(post_id:iteratedPost.id, text: "First message!", user_id:iteratedPost.connection.mentor.id)
            end
        end
    end
end