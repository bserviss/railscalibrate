class AddFieldsToCalibrators < ActiveRecord::Migration
  def self.up
    add_column :calibrators, :contact_email, :string
    add_column :calibrators, :contact_name, :string
    add_column :calibrators, :website, :string
  end

  def self.down
    remove_column :calibrators, :contact_email, :string
    remove_column :calibrators, :contact_name, :string
    remove_column :calibrators, :website, :string
  end
end
