namespace :app do
    desc "Create messages for all posts"
    task :message_creator => :environment do
        User.last.posts.each do |post|
            if post.connection.mentor.id == User.last.id 
                Message.create!(post_id:post_id, text: "First message!", user_id:post.connection.mentee.id)
            elsif post.connection.mentee.id == User.last.id 
                Message.create!(post_id:post_id, text: "First message!", user_id:post.connection.mentor.id)
            end
        end
    end
end