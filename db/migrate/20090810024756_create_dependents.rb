class CreateDependents < ActiveRecord::Migration
  def self.up
    create_table :dependents do |t|
      t.integer :item_id
      t.string :pn
      t.string :model
      t.string :note

      t.timestamps
    end
  end

  def self.down
    drop_table :dependents
  end
end
