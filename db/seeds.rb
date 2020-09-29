require 'faker'
require 'httparty'
require 'json'

Message.destroy_all
Post.destroy_all
Connection.destroy_all
User.destroy_all

MENTOR_TYPES = [
            "professional",
            "interpersonal",
            "self-improvement"
    ]

for i in 0..40 do 
    gender = (i % 2 == 0) ? "male" : "female"
    name = (gender == "female") ? Faker::Name.female_first_name : Faker::Name.male_first_name
    begin
        response = HTTParty.get("https://randomuser.me/api/?inc=picture&?gender=#{gender}&noinfo")
        userImage = JSON.parse(response.body)["results"][0]["picture"]["large"]
    rescue JSON::ParserError
        userImage = nil
    end
    user = User.create!(
        username: Faker::Internet.username(specifier: 7..12),
        first_name: name,
        last_name: Faker::Name.last_name,
        password: Faker::Alphanumeric.alpha(number: 10),
        birthdate: Faker::Date.birthday(min_age: 18, max_age: 65),
        gender: gender,
        avatar: userImage,
        karma: rand(1...50),
        professional: (rand(0..1) == 0 ? true : false),
        interpersonal: (rand(0..1) == 0 ? true : false),
        self_improvement: (rand(0..1) == 0 ? true : false),
        description: "(placeholder) looking to (work on Placeholder)!"
    )
end

for i in 0..50 do
    random_index = rand(0..2)
    accepted = (i % 2 == 0) ? true : false
    connection =  Connection.create!(
        mentee_id: User.all.sample.id,
        mentor_id: User.all.sample.id,
        accepted: accepted,
        mentor_type: MENTOR_TYPES[random_index]
    )

    post = Post.create!(
        connection: connection, mentee_name:connection.mentee.username, mentor_name:connection.mentor.username
    )
end
