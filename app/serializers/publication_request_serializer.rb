class PublicationRequestSerializer < ActiveModel::Serializer
  attributes :id, :event, :description, :dimensions, 
  					 :rough_date, :due_date, :event_date, :created_at, :updated_at, 
  					 :admin_id, :designer_id, :reviewer_id,
  					 :status

  belongs_to :user
  belongs_to :admin
  belongs_to :designer
  belongs_to :reviewer
  # has_and_belongs_to_many :templates
  has_many :comments
  has_many :request_attachments
end
