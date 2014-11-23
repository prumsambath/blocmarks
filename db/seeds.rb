require 'faker'

# seed users
5.times do
  User.create!(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: 'helloworld'
  )
end
users = User.all

# seed hashtags
50.times do
  Hashtag.create!(
    text: Faker::Lorem.word,
  )
end
hashtags = Hashtag.all

# seed bookmarks
200.times do
  tags = []
  1.upto(1 + rand(5)) do
    tags << hashtags.sample
  end
  Bookmark.create!(
    user: users.sample,
    url: Faker::Internet.url,
    hashtags: tags
  )
end
bookmarks = Bookmark.all

# like bookmarks
100.times do
  user = users.sample
  Favorite.create!(
    user: user,
    bookmark: bookmarks.where('user_id != ?', user.id).sample
  )
end

puts "Seed finished."
puts "#{User.count} users created."
puts "#{Hashtag.count} hashtags created."
puts "#{Bookmark.count} bookmarks creatd."
