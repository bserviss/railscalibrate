class Item < ActiveRecord::Base
 attr_accessible :picture, :description, :mfgr, :pn
 attr_accessible :org_sn, :mfgr_sn, :location, :cal_cycle_days, :last_calibrated_on
 attr_accessible :inactive, :inCal
 attr_accessible :per_page

  @@per_page = 10
 
 has_attached_file :picture, 
                   :styles => { :thumb => "50x50",
                                :small => "100x100",
                                :medium => "300x300"
                                }
                   #:url => "/system/pictures/:id/:basename.:extension",
                   #:path => ":rails_root/public/system/pictures/:id/:basename.:extension"

  validates_attachment_content_type :picture, :content_type => ['image/jpeg',
    'image/jpg', 'image/png'], :allow_nil => true

  has_many :events, :dependent => :destroy
  has_many :dependents, :dependent => :destroy
  has_many :issues, :dependent => :destroy

  validates_presence_of :description
  validates_presence_of :pn
  validates_presence_of :org_sn
  validates_presence_of :cal_cycle_days

  #change to an arbritary range of days
  scope :inactive, :conditions => ["inactive = ?", 1], :order => :last_calibrated_on
  scope :in_cal, :conditions => ["inCal = ? and inactive = ?", true, 0],
        :order => :last_calibrated_on

  def self.due_cal
    all( :conditions => ["(julianday('now') - julianday(items.last_calibrated_on)) >= items.cal_cycle_days and " +
          "inCal = ? and inactive = ?", false, 0 ],
        :order => :last_calibrated_on ) || []
  end
  
  def self.thirty_days
      all( :conditions => ["(julianday('now') - julianday(last_calibrated_on)) - ( cal_cycle_days )  < ? and " +
          "(julianday('now') - julianday(last_calibrated_on)) - ( cal_cycle_days - 30 ) >= ? and " +
          "inCal = ? and inactive = ?", 0, 0, false, 0],
        :order => :last_calibrated_on )
  end

  def self.sixty_days
    all( :conditions => ["(julianday('now') - julianday(last_calibrated_on)) - ( cal_cycle_days - 31)  < ? and " +
            "(julianday('now') - julianday(last_calibrated_on)) - ( cal_cycle_days - 60 ) >= ? and " +
            "inCal = ? and inactive = ?", 0, 0, false, 0],
          :order => :last_calibrated_on )
  end

  def self.ninety_days
    all(  :conditions => ["(julianday('now') - julianday(last_calibrated_on)) - ( cal_cycle_days - 61 )  < ? and " +
          "(julianday('now') - julianday(last_calibrated_on)) - ( cal_cycle_days - 90 ) >= ? and " +
          "inCal = ? and inactive = ?", 0, 0, false, 0],
        :order => :last_calibrated_on )
  end
  
end
