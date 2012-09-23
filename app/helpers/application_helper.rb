module ApplicationHelper
  #added helpers back after rails 3 upgrade
  def get_calibrator_name( calibrator_id )
    Calibrator.find( calibrator_id ).a_name
  end
  
  def get_calibrator_name_from_item( item_id )
    Calibrator.find( 
      Event.where("item_id=#{item_id}").order("created_at DESC").limit(1).first.calibrator_id
    ).a_name
  end
  
  def get_calibrator_id_from_item( item_id )
    item = Item.find( item_id )
    item.events.first( order: 'created_at DESC').calibrator_id
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
  
  def get_image_tag_from_item_id( an_id )
    my_item = Item.find( an_id )
    raw( "#{image_tag( my_item.picture.url(:small), :border=> 0)}" )
  end

end
