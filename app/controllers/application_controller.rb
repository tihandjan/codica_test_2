class ApplicationController < ActionController::API
  class PermissionDeniedError < StandardError; end
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :update_sanitized_params, if: :devise_controller?
  include CanCan::ControllerAdditions

  rescue_from CanCan::AccessDenied do |exception|
    render json: { message: exception.message }, status: 403
  end
  protected
  def update_sanitized_params
    added_attrs = [:email, :password, :password_confirmation, :name]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
