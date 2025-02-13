class ApplicationController < ActionController::API
  before_action :authenticate
  #before_action :ensure_json_request

  rescue_from CanCan::AccessDenied, with: :access_denied
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  attr_reader :current_user

  def route_not_found
    render json: { errors: "No route matches #{request.method} '#{request.path}'" }, status: :not_found
  end

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
      if @decoded.nil?
        render json: { errors: "Token inválido" }, status: :unauthorized
        return
      end
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def access_denied
    render json: { error: "Access Denied: You do not have permission to perform this action." }, status: :forbidden
  end

  def record_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def ensure_json_request
    unless request.headers["Accept"].to_s.include?("application/vnd.api+json")
      render json: { error: "Unsupported Media Type. Only application/vnd.api+json is allowed." }, status: :unsupported_media_type
      return
    end
  end
end
