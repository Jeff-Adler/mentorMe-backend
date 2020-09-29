namespace :app do
    desc "Testing random avatar generator API"
    task :seed_test => :environment do
        for i in 0..40 do 
            gender = (i % 2 == 0) ? "male" : "female"
            begin
                response = HTTParty.get("https://randomuser.me/api/?inc=picture&?gender=#{gender}&noinfo")
                userImage = JSON.parse(response.body)["results"][0]["picture"]["large"]
            rescue JSON::ParserError
                userImage = (gender == "female") ? 'https://avataaars.io/?avatarStyle=Circle&topType=LongHairStraight&accessoriesType=Blank&hairColor=BrownDark&facialHairType=Blank&clotheType=BlazerShirt&eyeType=Default&eyebrowType=Default&mouthType=Default&skinColor=Brown': 'https://getavataaars.com/?skinColor=Brown&topType=Hat'
            end
        end
    end
end