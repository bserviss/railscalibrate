module ApplicationHelper
  #added helpers back after rails 3 upgrade
  def get_calibrator_name( calibrator_id )
    Calibrator.find( calibrator_id).a_name
  end

  def get_item_count
    Item.all.count
  end

  def get_rough_due_cal_count
    #return a list of items due cal based on a 365 day assumption
    Item.find( :all, :conditions => ["last_calibrated_on < ? and inCal = ?", 1.year.ago, false]).count
  end

  def get_in_cal_count
    Item.all( :conditions => [ "inCal = ?", true ] ).count
  end

  def get_inactive_count
    Item.all( :conditions => ["inactive = ?", 1]).count
  end

  def get_item_description_from_id( an_id )
    Item.find(an_id).description
  end

  def get_item_org_sn_from_id( an_id )
    Item.find(an_id).org_sn
  end

end
