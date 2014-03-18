class HomeController < ApplicationController  
  
  def index
    @tasks = current_user.tasks_today unless current_user.nil?
    @today = DateTime.now
  end
  
end
