class UpdateFieldsForExternalDocs < ActiveRecord::Migration
  def self.up
    rename_column :external_docs, :items_id, :item_id
    add_column :external_docs, :description, :string
  end

  def self.down
    rename_column :external_docs, :item_id, :items_id
    remove_column :external_docs, :description
  end
end
