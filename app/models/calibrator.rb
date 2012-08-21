# == Schema Information
#
# Table name: calibrators
#
#  id             :integer          not null, primary key
#  a_name         :string(255)
#  address_line_1 :string(255)
#  address_line_2 :string(255)
#  city           :string(255)
#  state          :string(255)
#  zip            :string(255)
#  note           :string(255)
#  event_id       :integer
#  created_at     :datetime
#  updated_at     :datetime
#  contact_email  :string(255)
#  contact_name   :string(255)
#  website        :string(255)
#

class Calibrator < ActiveRecord::Base
  #belongs_to :event
  has_many :events
  validates_presence_of :a_name

  scope :all_by_name, :order => :a_name
end
