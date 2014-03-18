class Task < ActiveRecord::Base
  attr_accessible :content, :date_finished, :date_from, :duration, :name, :user_id, :project_id

  belongs_to :user
  belongs_to :project
  
  default_scope -> { order('date_from DESC') }
  validates :user_id, presence: true
  validates :project_id, presence: true
  validates :name, presence: true, length: { maximum: 140 }
  validates :date_from, presence: true
  validates :duration, presence: true

  def expected_end_time
    date_from + (duration).hours
  end

  def done_in_time?
    date_finished && (date_finished < expected_end_time)
  end

  def project_name
    Project.find(project_id).name
  end

end
