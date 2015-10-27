FactoryGirl.define do
	factory :publication_request do
		event "Test Event 2015"
		description "Awesome test event this weekend."
		rough_date "Mon, 17 Dec 2015 00:00:00 +0000"
		due_date "Mon, 17 Dec 2015 00:00:00 +0000"
		event_date "Mon, 17 Dec 2015 00:00:00 +0000" 
		dimensions "quarter"
		user
	end
end 