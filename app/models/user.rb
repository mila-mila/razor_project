class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  MAX_NR_WORKING_HOURS = 7

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :tasks, dependent: :destroy

  def tasks_today
   tasks.where(date_from: DateTime.now.beginning_of_day..DateTime.now.end_of_day)
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
end
