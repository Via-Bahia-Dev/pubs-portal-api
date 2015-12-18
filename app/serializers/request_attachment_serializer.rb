class RequestAttachmentSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :comment, :publication_request_id,
  								:file_file_name, :file_file_size, :file_original, :file_large, :file_medium, :file_small, :file_thumb

  belongs_to :user

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

  def file_thumb
  	object.file.url(:thumb)
  end
end
