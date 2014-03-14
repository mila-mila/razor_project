class HomeController < ApplicationController  
  
  def index
    @tasks = current_user.tasks unless current_user.nil?
  end
  
end
