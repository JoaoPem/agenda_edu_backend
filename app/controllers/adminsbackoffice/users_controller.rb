class Adminsbackoffice::UsersController < ApplicationController
  before_action :set_user, only: %i[ update show destroy ]
  def create
    @user = User.new(user_params)
    if @user.save
      render json: { message: "User created successfully", user: @user }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    render json: { message: "User deleted successfully" }
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
