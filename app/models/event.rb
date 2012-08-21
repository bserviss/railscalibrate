# == Schema Information
#
# Table name: events
#
#  id                 :integer          not null, primary key
#  item_id            :integer
#  cal_date           :datetime
#  calibrator_id      :integer
#  cost               :decimal(, )
#  po                 :string(255)
#  certs_file_name    :string(255)
#  certs_content_type :string(255)
#  certs_file_size    :integer
#  certs_updated_at   :datetime
#  created_at         :datetime
#  updated_at         :datetime
#

class Event < ActiveRecord::Base
  belongs_to :item 
  belongs_to :calibrators  # calibrators has many events
  
  has_attached_file :certs, :allow_nil => true,
                    :styles => { :medium => "300x300",
                                 :thumb => "100x100" }

  validates_attachment_content_type :certs, :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png', 'application/pdf'],
    :allow_nil => true

  validates_presence_of :cal_date
  validates_presence_of :calibrator_id

  scope :previous_10_events, :order => 'created_at DESC', :limit => 10
  
  def self.cost_over_year
    Event.sum(:cost, :conditions => ["created_at > ?", 1.year.ago])
  end
end
