class Usersbackoffice::UsersController < ApplicationController
  before_action :set_user, only: [ :update, :show ]

  def show
    render json: @user
  end

  def update
    if @user.update(user_params)
      render json: { message: "Profile updated successfully", user: @user }
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :profile_picture)
  end
end
