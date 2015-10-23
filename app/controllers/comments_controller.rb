class CommentsController < ApplicationController

  load_and_authorize_resource

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: { data: @comment }, status: :created
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
    @comments = Comment.all
    render json: { data: @comments }
  end

  def show
    render json: { data: @comment }
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :publication_request_id, :date, :content)
  end

end
