class TopController < ApplicationController
  skip_before_filter :find_login_user, only: [:about]
  def index
    render action: :about
  end
  def about
  end
end
