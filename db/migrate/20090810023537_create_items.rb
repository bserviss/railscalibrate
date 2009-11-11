class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :description
      t.string :mfgr
      t.string :pn
      t.string :org_sn
      t.string :mfgr_sn
      t.string :location
      t.integer :cal_cycle_days, :default => 365
      t.date :last_calibrated_on
      t.boolean :inCal, :default => false
      t.integer :inactive, :default => 0
      t.string :picture_file_name
      t.string :picture_content_type
      t.integer :picture_file_size
      t.datetime :picture_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
