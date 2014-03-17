class TasksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :date_today

  MAX_NR_WORKING_HOURS = 7

  def index
    @tasks = tasks_today
  end

  def new
    @task = current_user.tasks.new
  end
  
  def create
    @task = current_user.tasks.build(params[:task])
    if @task.save
      redirect_to tasks_path
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
    if @task.update_attributes(date_finished: DateTime.now)
      redirect_to @task
      flash[:notice] = "Task finished."
    else
      redirect_to @task
      flash[:notice] = "there was an error, task not marked as finished"
    end
  end

  def hours_left?
    remaining_hours_today > 0
  end

  def remaining_hours_today
    MAX_NR_WORKING_HOURS - tasks_today.sum(:duration)
  end

  def hours_drop_down
    Array.new(remaining_hours_today) { |e| Array.new(2) { |i| e+1 } }
  end

  def date_today
    DateTime.now
  end

  protected    

    def tasks_today
      current_user.tasks.
      where(date_from: date_today.beginning_of_day..date_today.end_of_day) unless current_user.nil?
    end

end