class CreateCalibrators < ActiveRecord::Migration
  def self.up
    create_table :calibrators do |t|
      t.string :a_name
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :note
      t.integer :event_id
      t.timestamps
    end
  end

  def self.down
    drop_table :calibrators
  end
end
