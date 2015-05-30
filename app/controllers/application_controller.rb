class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :find_login_user

  def find_login_user
    @login_user = User.find_by_id(session[:user_id])
    unless @login_user
      redirect_to login_url and return false
    end
  end

  private

  def admin_required
    unless @login_user.adm?
      redirect_to user_path(@login_user)
    end
  end
end
