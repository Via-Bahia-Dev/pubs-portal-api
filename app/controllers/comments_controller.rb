class CommentsController < ApplicationController

  load_and_authorize_resource

  def create
    @comment = Comment.new(comment_params)
    @comment.publication_request_id = params[:publication_request_id]
    @comment.user_id = current_user.id

    if @comment.save
      render json: { data: serialized_objects(@comment) }, status: :created
    else
      render json: { errors: @comment.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      head :no_content
    else
      render json: { errors: @comment.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    head :no_content
  end

  def index
    render json: { data: serialized_objects(@comments) }
  end

  def show
    render json: { data: serialized_objects(@comment) }
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
