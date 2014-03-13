class TasksController < ApplicationController
  before_filter :authenticate_user!

  def new
    @task = current_user.tasks.new
  end
  
  def create
    @task = current_user.tasks.build(params[:task])
    if @task.save
      redirect_to root_path
    else
      redirect_to root_path
      flash[:notice] = "Error on creating new tasks! ! !"
    end
  end
end