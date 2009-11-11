class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.integer :item_id
      t.datetime :cal_date
      t.integer :calibrator_id
      t.decimal :cost
      t.string :po
      t.string :certs_file_name
      t.string :certs_content_type
      t.integer :certs_file_size
      t.datetime :certs_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
