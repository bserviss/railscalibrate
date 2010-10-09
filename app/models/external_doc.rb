class ExternalDoc < ActiveRecord::Base
  belongs_to :items
  has_attached_file :doc, 
                   :styles => { :thumb => "50x50",
                                :small => "100x100",
                                :medium => "300x300"
                                }
 
  validates_attachment_content_type :doc, :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png', 'application/pdf'],
    :allow_nil => true
  
end
