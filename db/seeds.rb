# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

["Web Development Bootcamps", "Node.js", "Python", "Ruby"].each_with_index do |name, idx|
  topic = Topic.create(name: name)
  topic.courses.create(name: (idx == 0 ? name : "Introduce #{name}"))
end
