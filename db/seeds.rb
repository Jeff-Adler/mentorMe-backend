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

DESCRIPTION_BLURBS = [
    "HS student looking to improve my self-esteem.",
    "College student looking to work on my romanitc relationships.",
    "College student looking to find some hobbies.",
    "College student looking to be less shy.",
    "Early-career professional looking to get direction.",
    "Early-career professional looking to find a role in finance.",
    "Early-career professional looking to become a yoga teacher.",
    "Career changer looking to break into software engineering!",
    "Career changer looking to break into freelance!",
    "Career changer looking to learn more about entrepeneurship!"
]

for i in 0..40 do 
    gender = (i % 2 == 0) ? "male" : "female"
    name = (gender == "female") ? Faker::Name.unique.female_first_name : Faker::Name.unique.male_first_name
    begin
        response = HTTParty.get("https://randomuser.me/api/?gender=#{gender}&noinfo&?seed=#{name}")
        userImage = JSON.parse(response.body)["results"][0]["picture"]["large"]
    rescue JSON::ParserError
        userImage = nil
    end
    user = User.create!(
        username: Faker::Internet.unique.username(specifier: 7..12),
        first_name: name,
        last_name: Faker::Name.last_name,
        password: Faker::Alphanumeric.alpha(number: 10),
        birthdate: Faker::Date.birthday(min_age: 18, max_age: 65),
        gender: gender,
        avatar: userImage,
        professional: (rand(0..1) == 0 ? true : false),
        interpersonal: (rand(0..1) == 0 ? true : false),
        self_improvement: (rand(0..1) == 0 ? true : false),
        description: DESCRIPTION_BLURBS[rand(0..(DESCRIPTION_BLURBS.length - 1))]
    )
end

for i in 0..15 do 
    gender = (i % 2 == 0) ? "male" : "female"
    name = (gender == "female") ? Faker::Name.unique.female_first_name : Faker::Name.unique.male_first_name
    begin
        response = HTTParty.get("https://randomuser.me/api/?inc=picture&?gender=#{gender}&noinfo&?seed=#{name}")
        userImage = JSON.parse(response.body)["results"][0]["picture"]["large"]
    rescue JSON::ParserError
        userImage = nil
    end
    user = User.create!(
        username: Faker::Internet.unique.username(specifier: 7..12),
        first_name: name,
        last_name: Faker::Name.last_name,
        password: Faker::Alphanumeric.alpha(number: 10),
        birthdate: Faker::Date.birthday(min_age: 45, max_age: 65),
        gender: gender,
        avatar: userImage,
        professional: (rand(0..1) == 0 ? true : false),
        interpersonal: (rand(0..1) == 0 ? true : false),
        self_improvement: (rand(0..1) == 0 ? true : false),
        description: DESCRIPTION_BLURBS[rand(0..(DESCRIPTION_BLURBS.length - 1))]
    )
end

for i in 0..50 do
    accepted = (i % 2 == 0) ? true : false
    connection =  Connection.create!(
        mentee_id: User.all.sample.id,
        mentor_id: User.all.sample.id,
        accepted: accepted,
        mentor_type: MENTOR_TYPES[rand(0..2)]
    )

    post = Post.create!(
        connection: connection
    )
end
