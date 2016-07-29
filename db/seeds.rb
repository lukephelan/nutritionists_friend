# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Comment.create([{post_id: 1 , content: 'This is a great point.',
  like: true},
  {post_id: 2, content: 'This is not a very good point.',
    like: false}])
