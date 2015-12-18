class CommentSerializer < ActiveModel::Serializer
  attributes :id, :publication_request_id, :content, :created_at, :updated_at

  belongs_to :user
end
