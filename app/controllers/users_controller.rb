class UsersController < ApplicationController
  # skip_before_action :authenticate!, only: [:create]
  # before_action :set_user, only: [:show, :update, :destroy]
  load_and_authorize_resource

  def index
    @users = User.all
    render json: { data: serialized_objects(@users) }
  end

  def show
    if user_params
      @user = User.find_by(user_params)
    end
    render json: { data: serialized_objects(@user) }
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: { data: serialized_objects(@user) }, status: :created, location: @user
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
    @users = users_with_role(:admin)
    render json: { data: serialized_objects(@users) }
  end

  def designers
    @users = users_with_role(:designer)
    render json: { data: serialized_objects(@users) }
  end

  def reviewers
    @users = users_with_role(:reviewer)
    render json: { data: serialized_objects(@users) }
  end

  def update_password
    @change_password = ChangePassword.new(@user)
    if @change_password.submit(user_password_params)
      head :no_content
    else
      render json: { errors: @change_password.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :roles_mask, :password_reset_token, roles: [])
  end

  def user_password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end

  def users_with_role(role)
    users = []
    User.all.each do |user|
      users << user if user.has_role?(role)
    end
    users
  end
end
