class Event < ActiveRecord::Base
  belongs_to :calendar
  validates :title,     presence: true
  validates :starts_at, presence: true
  validates :ends_at,   presence: true
  validates_presence_of :calendar

  has_many_tags

  def duration
    ends_at - starts_at
  end
end
