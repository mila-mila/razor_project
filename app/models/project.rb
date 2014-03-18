class Project < ActiveRecord::Base
  attr_accessible :content, :name

  has_many :tasks, dependent: :destroy

  validates :name, presence: true, length: { maximum: 140 }
end
