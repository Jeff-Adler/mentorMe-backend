# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

Question.destroy_all
Answer.destroy_all
Post.destroy_all
Connection.destroy_all
User.destroy_all

for i in 0..20 do
    gender = (i % 2 == 0) ? "male" : "female"

    user = User.create!(
        username: Faker::Internet.username(specifier: 7..12),
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        password: Faker::Alphanumeric.alpha(number: 10),
        birthdate: Faker::Date.birthday(min_age: 18, max_age: 65),
        gender: gender,
        avatar: Faker::Alphanumeric.alpha(number: 10),
        prof_q1: Faker::Alphanumeric.alpha(number: 10),
        prof_q2: Faker::Alphanumeric.alpha(number: 10),
        prof_q3: Faker::Alphanumeric.alpha(number: 10),
        karma: rand(1...50)
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
