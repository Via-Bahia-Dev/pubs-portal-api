class UsersController < ApplicationController
  # skip_before_action :authenticate!, only: [:create]
  # before_action :set_user, only: [:show, :update, :destroy]
  load_and_authorize_resource

  def index
    @users = User.all
    render json: { data: @users }
  end

  def show
    render json: { data: @user }
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: { data: @user }, status: :created, location: @user
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      head :no_content
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  def admins
  end

  def designers
  end

  def reviewers
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :first_name, :last_name, :roles_mask)
    end
end
