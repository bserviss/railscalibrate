class Event < ActiveRecord::Base
  belongs_to :item 
  belongs_to :calibrators  # calibrators has many events
  
  has_attached_file :certs,
                    :styles => { :medium => "300x300>",
                                 :thumb => "100x100>" }

  validates_attachment_content_type :certs, :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png', 'application/pdf'] 

  validates_presence_of :cal_date
  validates_presence_of :calibrator_id
  
end
