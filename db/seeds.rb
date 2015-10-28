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

(1..5).each do |i|
	PublicationRequest.create(event: "Test Event #{2015+i}", description: "Awesome test event this weekend.",  rough_date: "Mon, #{17+i} Dec 2015 00:00:00 +0000", due_date: "Mon, 17 Dec 2015 00:00:00 +0000", event_date: "Mon, 17 Dec 2015 00:00:00 +0000", dimensions: "quarter", user_id: i, admin_id: 2, designer_id: 3, reviewer_id: 4, status: "In Progress")
end

(1..5).each do |i|
	Template.create(name: "Test Template #{i}", user_id: i,  dimensions: "5x#{i+1}" )
end		

(1..5).each do |i|
	Comment.create(user_id: i, publication_request_id: i,  date: "Mon, #{17+i} Dec 2015 00:00:00 +0000", content: "This is test comment #{i}." )
end	

(1..5).each do |i|
	RequestAttachment.create(publication_request_id: i, file: File.new(Rails.root + 'app/assets/images/test-image.jpg'), user_id: i )
end	
