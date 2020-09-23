namespace :app do
    desc "Create posts for User.last"
    task :post_creator => :environment do
        Connection.all.each do |connection|
            if connection.post == nil
                Post.create!(connection_id: connection.id, mentee_name: connection.mentee.username, mentor_name: connection.mentor.username) 
            end
        end
    end
end