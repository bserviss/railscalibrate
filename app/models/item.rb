class Item < ActiveRecord::Base
 has_attached_file :picture, 
                    :styles => { :medium => "300x300>",
                                 :thumb => "100x100>" }

  validates_attachment_content_type :picture, :content_type => ['image/jpeg',
    'image/jpg', 'image/png']

  has_many :events, :dependent => :destroy
  has_many :dependents, :dependent => :destroy

  validates_presence_of :description
  validates_presence_of :pn
  validates_presence_of :org_sn
  validates_presence_of :cal_cycle_days
  
end
