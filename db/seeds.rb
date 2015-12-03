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

Template.create(name: "A2F Homegroup Kickoff 2015", user_id: 1, dimensions: "2x3", type: "Welcome Night", image: File.new('/home/lfu/Pictures/PubsPortal/20150808_a2fhomegroupkickoff_jl_front_portfolio.jpg'), link: "https://www.dropbox.com/sh/4pgm0dsivaczsua/AAC7WUkcIN3pQJ2thKeqnTnma?dl=0")
Template.create(name: "A2F Welcome Night 2015", user_id: 1, dimensions: "2x3", type: "Welcome Night", image: File.new('/home/lfu/Pictures/PubsPortal/a2fwelcomenight_front_final_portfolio.jpg'), link: 'https://www.dropbox.com/sh/y082dw5jdaecxz7/AAA7m3xXPcqQW9koSEZ5OjaNa?dl=0')
Template.create(name: "Gracepoint Live 2015", user_id: 1, dimensions: "2x3", type: "Production", image: File.new('/home/lfu/Pictures/PubsPortal/20150806_glive-flyer_jl_portfolio.jpg'), link: 'https://www.dropbox.com/sh/aww31psowvmc4n8/AAAFKwTgYgqTY9xxD46qr8pca?dl=0')
Template.create(name: "Koinonia Welcome Night 2015", user_id: 1, dimensions: "2x3", type: "Welcome Night", image: File.new('/home/lfu/Pictures/PubsPortal/082015_nswn_flyerfront_oliviachou_portfolio.jpg'), link: 'https://www.dropbox.com/sh/lccki7fn7aj5k1o/AAAOlXDVzas-T8u6s8QfwjmNa/Flyers/PSDs/NSWN?dl=0')
Template.create(name: "Klesis Welcome Night 2015", user_id: 1, dimensions: "3x2", type: "Welcome Night", image: File.new('/home/lfu/Pictures/PubsPortal/20150728_welcomenightflyer_front_lg_6x4.jpg'), link: 'https://www.dropbox.com/sh/b2uu983kv4kxm96/AAAfa0H4EbK6hN_1NBU66XBPa/Fall%20Welcome%20Week%20Material/Welcome%20Night%20Materials?dl=0')