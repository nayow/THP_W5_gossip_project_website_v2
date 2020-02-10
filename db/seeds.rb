require 'faker'

# resetting tables before creating everything
City.destroy_all
User.destroy_all
Like.destroy_all
Comment.destroy_all
Gossip.destroy_all
Tag.destroy_all
JoinTableGossipTag.destroy_all
CommentOfComment.destroy_all
PrivateMessage.destroy_all

# creating fake cities
10.times do
  City.create(
    name: Faker::Address.city,
    zip_code: Faker::Address.zip
  )
end

# creating fake users
10.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::Quote.most_interesting_man_in_the_world,
    email: Faker::Internet.email,
    age: rand(10..80),
    city_id: rand(City.first.id..City.last.id) # random city amongst the previously created ones
  )
end

# creating fake gossips
20.times do
  Gossip.create(
    user_id: rand(User.first.id..User.last.id), # random gossip amongst the previously created ones
    title: Faker::Quote.singular_siegler,
    content: Faker::ChuckNorris.fact,
    date: Faker::Time.backward(days: 10)
  )
end

# creating fake tags
10.times do
  Tag.create(
    title: '#'+Faker::Company.profession,
  )
end

#creating fake gossips-tags
for i in Gossip.first.id..Gossip.last.id do # applying tags to every gossip
  tags_array = Array.new
  for t in Tag.first.id..Tag.last.id do # initializing an array with all tag_ids
    tags_array << t
  end
  rand(1..Tag.count).times do # at least one tag
    random_tag_id = tags_array.uniq.sample # random and unique tag in the array
    JoinTableGossipTag.create(
      gossip_id: i,
      tag_id: random_tag_id
    )
    tags_array.delete(random_tag_id) # one tag can't be used twice for the same gossip
  end
end

# creating fake comments 
20.times do
  Comment.create(
    content: Faker::Quote.famous_last_words,
    user_id: rand(User.first.id..User.last.id), # random user amongst the previously created ones
    gossip_id: rand(Gossip.first.id..Gossip.last.id) # random gossip amongst the previously created ones
  )
end

# creating comments of comments
20.times do
  CommentOfComment.create(
    content: Faker::Quote.yoda,
    user_id: rand(User.first.id..User.last.id), # random user amongst the previously created ones
    comment_id: rand(Comment.first.id..Comment.last.id) # random comment amongst the previously created ones
  )
end

# creating fake likes
20.times do
  like = Like.new(user_id: rand(User.first.id..User.last.id))
  if rand(0..1) == 1 # either gossip or comment
    like.gossip_id = rand(Gossip.first.id..Gossip.last.id)
  else
    like.comment_id = rand(Comment.first.id..Comment.last.id)
  end
  like.save
end

# creating fake private messages
10.times do 
  pm = PrivateMessage.new(content: Faker::Quote.famous_last_words)
  pm.sender_id = rand(User.first.id..User.last.id) # random sender amongst the previously created users
  pm.recipient_id = rand(User.first.id..User.last.id)
  until pm.recipient_id != pm.sender_id # random recipient has to be different than the sender
    pm.recipient_id = rand(User.first.id..User.last.id)
  end
  pm.save
end 



