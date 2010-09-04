class Calibrator < ActiveRecord::Base
  #belongs_to :event
  has_many :events
  validates_presence_of :a_name

  scope :all_by_name, :order => :a_name
end
