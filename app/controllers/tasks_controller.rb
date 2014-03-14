class TasksController < ApplicationController
  before_filter :authenticate_user!

  def new
    @task = current_user.tasks.new
    @remainingHoursToday = 7 - current_user.tasks.
                where(date_from: DateTime.now.beginning_of_day..DateTime.now.end_of_day).sum(:duration)
    @hoursDropDown = [[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]][0..@remainingHoursToday-1]
  end
  
  def create
    @task = current_user.tasks.build(params[:task])
    if @task.save
      redirect_to root_path
    else
      redirect_to new_task_path
      flash[:notice] = "Error on creating new tasks! ! !"
    end
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update_attributes(date_finished: DateTime.current)
      redirect_to @task
      flash[:notice] = "Task finished."
    else
      redirect_to @task
      flash[:notice] = "there was an error, task not marked as finished"
    end
  end

end