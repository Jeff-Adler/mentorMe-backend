namespace :app do
    desc "Create mentorships requests to User.last"
    task :request_creator => :environment do
        User.all.each do |user|
            Connection.create!(mentee_id: user.id, mentor_id: User.last.id) unless user.id == User.last.id 
        end
    end
end