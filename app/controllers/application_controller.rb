class ApplicationController < ActionController::API
  before_action :authenticate

  private

  def authenticate
    header = request.headers["Authorization"]
    token  = header.split(" ").last if header

    if header.blank?
      render json: { errors: "Authorization header is missing" }, status: :unauthorized
      return
    end

    begin
      @decoded = JsonWebToken.decode(token)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
