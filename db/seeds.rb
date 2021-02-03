require 'faker'

40.times {
    Like.create(user_id: rand(31..41), blog_id: rand(17..27))
}

20.times {
    Comment.create( user_id: rand(31..41), 
                    blog_id: rand(17..27),
                    comment: Faker::TvShows::NewGirl.quote)
}
