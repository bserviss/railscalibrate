class Calibrator < ActiveRecord::Base
  #belongs_to :event
  has_many :events
  validates_presence_of :a_name

end
