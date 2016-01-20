class PublicationRequestSerializer < ActiveModel::Serializer
  attributes :id, :event, :description, :dimensions, 
  					 :rough_date, :due_date, :event_date, :created_at, :updated_at, 
  					 :admin_id, :designer_id, :reviewer_id,
  					 :status
             
  belongs_to :user
  belongs_to :admin
  belongs_to :designer
  belongs_to :reviewer
  has_many :comments
  has_many :request_attachments
  belongs_to :template

  class CommentSerializer < ActiveModel::Serializer
    attributes :id, :content, :created_at, :updated_at, :user

    def user
      { id: object.user.id,
        first_name: object.user.first_name,
        last_name: object.user.last_name,
        email: object.user.email
      }
    end
  end

end
