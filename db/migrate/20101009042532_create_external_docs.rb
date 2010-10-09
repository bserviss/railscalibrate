class CreateExternalDocs < ActiveRecord::Migration
  def self.up
    create_table :external_docs do |t|
      t.string :docs_file_name
      t.string :docs_content_type
      t.integer :docs_file_size
      t.datetime :docs_updated_at
      t.integer :items_id

      t.timestamps
    end
  end

  def self.down
    drop_table :external_docs
  end
end
