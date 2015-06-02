class TagsController < ApplicationController
  before_action :retrieve_user
  before_action :find_task

  def create
    unless params[:name].blank?
      tag = Tag.where(name: params[:name]).first ||
            Tag.create(name: params[:name])
      @task.tags << tag unless @task.tags.where(id: tag.id).first
    end
    redirect_to user_task_path(@user, @task)
  end

  def destroy
    if tag = Tag.where(name: params[:name]).first
      @task.tags.delete(tag)
    end
    redirect_to user_task_path(@user, @task)
  end

  def find_task
    @task = @user.tasks.find(params[:task_id])
  end

  def retrieve_user
    unless @user = User.where(id: params[:user_id]).first and
           (@login_user.adm? or @login_user.id == @user.id)
      redirect_to user_path(@login_user)
    end
  end
end
