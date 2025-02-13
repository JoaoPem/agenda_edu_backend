class Adminsbackoffice::UsersController < ApplicationController
  load_and_authorize_resource

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
    if stale?(etag: @users, last_modified: @users.maximum(:updated_at))
      render json: @users
    end
  end

  def show
    if stale?(etag: @topic, last_modified: @topic.updated_at)
      render json: @user
    end
  end

  def update
    ActiveRecord::Base.transaction do
      if user_params.key?(:parent_ids)
        if @user.student?
          if user_params[:parent_ids].present?
            parents = User.where(id: user_params[:parent_ids], role: :parent)

            missing_parents = user_params[:parent_ids].map(&:to_i) - parents.pluck(:id)
            if missing_parents.any?
              raise ActiveRecord::RecordNotFound, "Pais não encontrados: #{missing_parents.join(', ')}"
            end

            @user.parents = parents
          else
            @user.parents.clear
          end
        else
          return render json: { error: "Apenas usuários do tipo 'student' podem ter pais associados" }, status: :unprocessable_entity
        end
      end

      if @user.update(user_params.except(:parent_ids))
        render json: { message: "Usuário atualizado com sucesso", user: @user }
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def destroy
    @user.destroy
    # render json: { message: "User deleted successfully" }
    head :no_content
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :current_password, :password_confirmation, :role, parent_ids: [])
  end

  def set_user
    @user = User.find(params[:id])
  end
end
