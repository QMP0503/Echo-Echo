class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Simple authentication for demo purposes
  before_action :authenticate_user!

  private

  def authenticate_user!
    @current_user = User.find(session[:user_id]) if session[:user_id]
    redirect_to login_path unless @current_user
  end

  def current_user
    @current_user
  end
  helper_method :current_user

  def current_classroom
    @current_classroom ||= current_user&.classroom
  end
  helper_method :current_classroom

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?
end
