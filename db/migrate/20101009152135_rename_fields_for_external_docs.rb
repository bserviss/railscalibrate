class RenameFieldsForExternalDocs < ActiveRecord::Migration
  def self.up
    rename_column :external_docs, :docs_file_name, :doc_file_name
    rename_column :external_docs, :docs_content_type, :doc_content_type
    rename_column :external_docs, :docs_file_size, :doc_file_size
    rename_column :external_docs, :docs_updated_at, :doc_updated_at
  end

  def self.down
  end
end
