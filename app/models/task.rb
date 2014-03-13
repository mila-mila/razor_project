class Task < ActiveRecord::Base
  attr_accessible :content, :date_finished, :date_from, :date_to, :name, :user_id

  belongs_to :user
  default_scope -> { order('date_from DESC') }
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 140 }
  validates :date_from, presence: true
end
