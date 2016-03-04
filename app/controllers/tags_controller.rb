class TagsController < ApplicationController
  def index
    @tags = Tag.all
    render json: { data: serialized_objects(@tags) }
  end
end
