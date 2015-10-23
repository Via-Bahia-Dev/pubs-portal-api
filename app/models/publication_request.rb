class PublicationRequest < ActiveRecord::Base
	validates_presence_of :event, :description, :rough_date, :due_date, :event_date, :user_id, :dimensions

	belongs_to :user
	has_many :comments
end
