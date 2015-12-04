class TemplatesController < ApplicationController

  load_and_authorize_resource

  def index
    @templates = Template.all
    render json: { data: serialized_templates(@templates) }
  end

  def show
    render json: { data: serialized_templates(@template) }
  end

  def create
    @template = Template.new(template_params)

    if @template.save
      render json: { data: @template }, status: :created
    else
      render json: { errors: @template.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @template.destroy
    head :no_content
  end

  def update
    if @template.update(template_params)
      head :no_content
    else
      render json: { errors: @template.errors }, status: :unprocessable_entity
    end
  end

  private

  def template_params
    params.require(:template).permit(:name, :user_id, :dimensions, :image, :link, :category)
  end

  def serialized_templates(objects)
    ActiveModel::SerializableResource.new(objects).serializable_hash
  end

end
