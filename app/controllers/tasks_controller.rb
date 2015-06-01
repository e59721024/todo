class TasksController < ApplicationController
  require 'csv'
  before_action :retrieve_user
  before_action :set_task, only: [:edit, :update, :destroy]
  def index
    @name = params[:name]
    @task = @user.tasks.like_name(@name).all
  end

  def new
    @task = @user.tasks.new
  end

  def edit
  end
  
  def create
    @task = @user.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to user_tasks_url(@user), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :action => :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to user_tasks_url(@user), notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    redirect_to user_tasks_url(@user)
  end

  def download
    @tasks - @user.tasks
    csvs = CSV.generate do |csv|
      @tasks.each do |task|
        csv << [task.name, task.deadline.strftime("%Y-%m-%d %H:%M:%S"), task.priority]
      end
    end
    send_data csvs, :type => 'text/csv', :filename => 'tasks.csv'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = @user.tasks.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :deadline, :priority)
    end

    def retrieve_user
      unless @user = User.where(id: params[:user_id]).first and
            (@login_user.adm? or @login_user.id == @user.id)
        redirect_to user_path(@login_user)
      end
    end

end
