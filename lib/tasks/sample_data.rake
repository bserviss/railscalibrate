namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Item.create!(description: "Test Item",
                 mfgr: "test",
                 pn: "test",
                 org_sn: "1234",
                 cal_cycle_days:  "365",
                 last_calibrated_on: Date.today,
                 )
    99.times do |n|
      a_description  = "Test-#{n+1}"
      some_days = rand(500)
      a_date = Date.today
      a_date -= some_days
      a_sn = rand(1000)
      Item.create!(description: a_description,
                 mfgr: "test",
                 pn: "test",
                 org_sn: a_sn,
                 cal_cycle_days:  "365",
                 last_calibrated_on: a_date
                 )
    end
    Calibrator.create!(
      a_name: "test Vendor",
      contact_name: "test"
      )
    5.times do |n|
      the_name = "Vendor-#{n + 1}"
      the_contact_name = "test"
      Calibrator.create!( a_name: the_name, contact_name: the_contact_name)
    end
  end
end
