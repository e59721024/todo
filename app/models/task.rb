class Task < ActiveRecord::Base
  belongs_to :user
  has_many :task_tags
  has_many :tags, through: :task_tags
  validates :name, presence: true, uniqueness: true
  validates :deadline, presence: true
  validates :priority, inclusion: { in: 1..3 }
  scope :near_deadline, lambda{ where('deadline < ?', 1.days.since) }
  scope :high, lambda{ where(priority: 2) }
  scope :by_name, lambda{|name|
    where(:name => name) if name.present?}
  scope :like_name, lambda{ |name|
    where("name like ?", "%#{name}%") if name.present? }
end
