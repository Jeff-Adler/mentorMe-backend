require 'faker'
require 'httparty'
require 'json'

Question.destroy_all
Answer.destroy_all
Post.destroy_all
Connection.destroy_all
User.destroy_all

for i in 0..20 do
    gender = (i % 2 == 0) ? "male" : "female"
    response = HTTParty.get("https://randomuser.me/api/?inc=picture&?gender=#{gender}&noinfo")
    userImage = JSON.parse(response.body)["results"][0]["picture"]["large"]

    user = User.create!(
        username: Faker::Internet.username(specifier: 7..12),
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        password: Faker::Alphanumeric.alpha(number: 10),
        birthdate: Faker::Date.birthday(min_age: 18, max_age: 65),
        gender: gender,
        avatar: userImage,
        karma: rand(1...50),
        professional: (rand(0..1) == 0 ? true : false),
        interpersonal: (rand(0..1) == 0 ? true : false),
        self_improvement: (rand(0..1) == 0 ? true : false),
        description: "I'm a (placeholder) looking to (work on Placeholder)!"
    )
end

for i in 0..40 do
    accepted = (i % 2 == 0) ? true : false
    connection =  Connection.create!(
        mentee_id: User.all.sample.id,
        mentor_id: User.all.sample.id,
        accepted: accepted
    )

    post = Post.create!(
        connection: connection, mentee_name:connection.mentee.username, mentor_name:connection.mentor.username
    )

    question = Question.create!(
        question: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4),
        post: post
    )

    answer = Answer.create!(
        answer: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4),
        post: post
    )
end
