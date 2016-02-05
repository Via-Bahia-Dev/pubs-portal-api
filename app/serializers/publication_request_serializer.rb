class PublicationRequestSerializer < ActiveModel::Serializer
  attributes :id, :event, :description, :dimensions,
  					 :rough_date, :due_date, :event_date, :created_at, :updated_at,
  					 :admin_id, :designer_id, :reviewer_id

  belongs_to :user
  belongs_to :admin
  belongs_to :designer
  belongs_to :reviewer
  belongs_to :status
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

  class RequestAttachmentSerializer < ActiveModel::Serializer
    attributes :id, :created_at, :updated_at, :comment, :publication_request_id,
                :file_file_name, :file_file_size, :file_content_type,
                :file_original, :file_large, :file_medium, :file_small, :file_large_thumb, :file_thumb,
                :user

    def file_original
      object.file.url
    end

    def file_large
      object.file.url(:large)
    end

    def file_medium
      object.file.url(:medium)
    end

    def file_small
      object.file.url(:small)
    end

    def file_large_thumb
      object.file.url(:large_thumb)
    end

    def file_thumb
      object.file.url(:thumb)
    end

    def user
      { id: object.user.id,
        first_name: object.user.first_name,
        last_name: object.user.last_name,
        email: object.user.email
      }
    end
  end

end
