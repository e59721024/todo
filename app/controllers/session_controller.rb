# coding: utf-8
class SessionController < ApplicationController
  skip_before_filter :find_login_user, only: [:new, :create]
  def new
  end

  def create
    @email = params[:email]
    @password = params[:password]
    @user = User.authenticate(@email, @password)
    session[:user_id] = @user.try(:id)
    if @user.nil?
      flash.now[:alert] = 'Login failed!'
      render action: :new
    elsif @user.try(:adm?)
      flash[:notice] = 'Login success!'
      redirect_to users_path
    else
      redirect_to user_path(@user)
    end
  end

  def destroy
    reset_session
    redirect_to root_url
  end
end
