# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

(1..5).each do |num|
	user = User.create({ email: "test#{num}@test.com", password: "asdfasdf", first_name: "Test", last_name: "#{num}" })
	user.add_roles([User.ROLES[num-1]])
end