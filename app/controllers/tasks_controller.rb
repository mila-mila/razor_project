class TasksController < ApplicationController
  before_filter :authenticate_user!

  def index
    @tasks = current_user.tasks_today
  end

  def new
    @task = current_user.tasks.new
  end
  
  def create
    @task = current_user.tasks.build(params[:task])
    if @task.save
      redirect_to root_path
    else
      render 'new'
      flash[:notice] = "Error on creating new tasks! ! !"
    end
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update_attributes(date_finished: DateTime.now)
      redirect_to @task
      flash[:notice] = "Task finished."
    else
      redirect_to @task
      flash[:notice] = "there was an error, task not marked as finished"
    end
  end

end