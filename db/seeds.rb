require 'faker'

10.times { 
    funny_name = Faker::FunnyName.two_word_name
    user = User.create(name: funny_name,
                email: funny_name + '@gmail.com',
                password_digest: "123")
    
    3.times {
        Blog.create(title: Faker::Hipster.word,
                    content: Faker::Hipster.paragraph,
                    private: false,
                    user_id: user.id)
    }
}

20.times {
    Like.create(user_id: rand(13..43), blog_id: rand(2..31))
}

20.times {
    Comment.create( user_id: rand(13..43), 
                    blog_id: rand(2..31),
                    comment: Faker::TvShows::NewGirl.quote)
}