# == Schema Information
#
# Table name: items
#
#  id                   :integer          not null, primary key
#  description          :string(255)
#  mfgr                 :string(255)
#  pn                   :string(255)
#  org_sn               :string(255)
#  mfgr_sn              :string(255)
#  location             :string(255)
#  cal_cycle_days       :integer          default(365)
#  last_calibrated_on   :date
#  inCal                :boolean          default(FALSE)
#  inactive             :integer          default(0)
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  created_at           :datetime
#  updated_at           :datetime
#

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
 
  validates_attachment_content_type :picture, :content_type => ['image/jpeg',
    'image/jpg', 'image/png'], :allow_nil => true

  has_many :events, :dependent => :destroy
  has_many :dependents, :dependent => :destroy
  has_many :issues, :dependent => :destroy
  has_many :external_docs, :dependent => :destroy

  validates_presence_of :description
  validates_presence_of :pn
  validates_presence_of :org_sn
  validates_presence_of :cal_cycle_days

  scope :inactive, :conditions => ["inactive = ?", 1], :order => :last_calibrated_on
  scope :in_cal, :conditions => ["inCal = ? and inactive = ?", true, 0],
        :order => :last_calibrated_on
  scope :not_in_cal, :conditions => ["inCal = ? and inactive = ?", false, 0],
        :order => :last_calibrated_on

  def self.due_cal
    not_in_cal.all( :conditions => ["(julianday('now') - julianday(items.last_calibrated_on)) >= items.cal_cycle_days"],
        :order => :last_calibrated_on ) || []
  end

  def self.due_in( number_of_days )
    cal_list = not_in_cal.all
    result_list = []
    for item in cal_list 
      if ((item.last_calibrated_on > Date.today - item.cal_cycle_days.days) and
        (item.last_calibrated_on < Date.today - (item.cal_cycle_days - number_of_days)))
        result_list << item 
      end 
    end
    result_list
#    not_in_cal.all( 
#      :conditions => ["last_calibrated_on between date('now', '-cal_cycle_days days') and date('now', '-cal_cycle_days days') , '-? days' )", 
#       number_of_days  
#      ])
    #SELECT * FROM members WHERE membership_date < date('now', '-3 months');
#    not_in_cal.all( 
#      :conditions => ["last_calibrated_on between ? and ?", 
#      Date.today - cal_cycle_days.days,
#      Date.today - ( cal_cycle_days - number_of_days ).days 
#      ])
    
    #might need to do sql datediffs?  
    #not_in_cal.all( :conditions => ["(julianday('now') - julianday(last_calibrated_on)) - ( cal_cycle_days - #{number_of_days + 1} )  < 0 and " +
    #        "(julianday('now') - julianday(last_calibrated_on)) - ( cal_cycle_days - #{number_of_days } ) >= 0"],
    #      :order => :last_calibrated_on )
  end
  
  #Item.find( :all, :conditions => ["last_calibrated_on between ? and ?", Date.today - 3.months, Date.today])
end
