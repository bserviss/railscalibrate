class Item < ActiveRecord::Base
 has_attached_file :picture, 
                    :styles => { :medium => "300x300>",
                                 :thumb => "100x100>" }

  validates_attachment_content_type :picture, :content_type => ['image/jpeg',
    'image/jpg', 'image/png']

  has_many :events, :dependent => :destroy
  has_many :dependents, :dependent => :destroy
  has_many :issues, :dependent => :destroy

  validates_presence_of :description
  validates_presence_of :pn
  validates_presence_of :org_sn
  validates_presence_of :cal_cycle_days

  #change to an arbritary range of days

  def self.due_cal
    find( :all,
        :conditions => ["(julianday('now') - julianday(items.last_calibrated_on)) >= items.cal_cycle_days and " +
          "inCal = ? and inactive = ?", false, 0 ],
        :order => :last_calibrated_on ) || []
  end

  def self.inactive
    find( :all, :conditions => ["inactive = ?", 1], :order => :last_calibrated_on )
  end

  def self.in_cal
    find( :all, :conditions => ["inCal = ? and inactive = ?", true, 0],
        :order => :last_calibrated_on )
  end
  
  def self.thirty_days
      find( :all,
        :conditions => ["(julianday('now') - julianday(last_calibrated_on)) - ( cal_cycle_days )  < ? and " +
          "(julianday('now') - julianday(last_calibrated_on)) - ( cal_cycle_days - 30 ) >= ? and " +
          "inCal = ? and inactive = ?", 0, 0, false, 0],
        :order => :last_calibrated_on )
  end

  def self.sixty_days
    find( :all,
          :conditions => ["(julianday('now') - julianday(last_calibrated_on)) - ( cal_cycle_days - 31)  < ? and " +
            "(julianday('now') - julianday(last_calibrated_on)) - ( cal_cycle_days - 60 ) >= ? and " +
            "inCal = ? and inactive = ?", 0, 0, false, 0],
          :order => :last_calibrated_on )
  end

  def self.ninety_days
    find( :all,
        :conditions => ["(julianday('now') - julianday(last_calibrated_on)) - ( cal_cycle_days - 61 )  < ? and " +
          "(julianday('now') - julianday(last_calibrated_on)) - ( cal_cycle_days - 90 ) >= ? and " +
          "inCal = ? and inactive = ?", 0, 0, false, 0],
        :order => :last_calibrated_on )
  end
  
end
