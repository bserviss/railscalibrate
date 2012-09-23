module ItemsHelper
  def show_sn_and_last_cal( item )
    raw( "The Serial Number is #{ item.org_sn } " +
      "and it is/was due cal on #{ h (item.last_calibrated_on + item.cal_cycle_days.days).strftime('%m/%d/%Y')}" )
  end
end
