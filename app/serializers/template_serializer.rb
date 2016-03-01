class TemplateSerializer < ActiveModel::Serializer
  attributes :id, :name, :user_id, :dimensions, :image_file_name, :image_file_size, :image_original, :image_large, :image_medium, :image_small, :image_large_thumb, :image_thumb, :link

  def image_original
  	object.image.url
  end

  def image_large
  	object.image.url(:large)
  end

  def image_medium
  	object.image.url(:medium)
  end

  def image_small
  	object.image.url(:small)
  end

  def image_large_thumb
    object.image.url(:large_thumb)
  end

  def image_thumb
  	object.image.url(:thumb)
  end
end
