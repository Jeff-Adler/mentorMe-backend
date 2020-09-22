namespace :app do
    desc "Create connection requests to User.last"
    task :pending_creator => :environment do
        User.all.each do |user|
            random_boolean = [true, false].sample
            random_boolean2 = [true, false].sample
            if random_boolean == true
                Connection.create!(mentee_id: user.id, mentor_id: User.last.id, accepted: random_boolean2) unless user.id == User.last.id 
            else
                Connection.create!(mentee_id: User.last.id, mentor_id: user.id, accepted: random_boolean2) unless user.id == User.last.id 
            end
        end
    end
end