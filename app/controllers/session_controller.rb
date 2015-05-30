# coding: utf-8
class SessionController < ApplicationController
  skip_before_filter :find_login_user, only: [:new, :create]
  def new
  end

  def create
    @email = params[:email]
    @password = params[:password]
    @user = User.authenticate(@email, @password)
    # if @user
    #   session[:user_id] = @user.id
    #   flash[:notice] = 'login success!'
    #   redirect_to tasks_url
    if !@user
      @error = 'login failed!'
      render action: :new
      binding.pry
    elsif @user.try(:adm?)
      session[:user_id] = @user.id
      flash[:notice] = 'login success!'
      redirect_to users_path
    else
      # session[:user_id] = @user.id
      # flash[:notice] = 'login success!'
      redirect_to user_path(@user)
    end
  end

  def destroy
    reset_session
    redirect_to root_url
  end
end
