# require 'faker'

# 8.times { 
#     funny_name = Faker::FunnyName.two_word_name
#     user = User.create(name: funny_name,
#                 email: funny_name + '@gmail.com',
#                 password_digest: "123")
    
#     3.times {
#         Blog.create(title: Faker::Hipster.word,
#                     content: Faker::Hipster.paragraph,
#                     private: [true, false].sample,
#                     user_id: user.id,
#                     image: Faker::Avatar.image)
#     }
# }

# names = ["Ellaine"]
# names.map do |name| User.create(name: name, email: name + '@gmail.com', password_digest: "123") end

40.times {
    Like.create(user_id: rand(31..41), blog_id: rand(17..27))
}

20.times {
    Comment.create( user_id: rand(31..41), 
                    blog_id: rand(17..27),
                    comment: Faker::TvShows::NewGirl.quote)
}

#user_id: rand(31..41)