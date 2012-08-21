# == Schema Information
#
# Table name: external_docs
#
#  id               :integer          not null, primary key
#  doc_file_name    :string(255)
#  doc_content_type :string(255)
#  doc_file_size    :integer
#  doc_updated_at   :datetime
#  item_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#  description      :string(255)
#

class ExternalDoc < ActiveRecord::Base
  belongs_to :items
  has_attached_file :doc, 
                   :styles => { :thumb => "50x50",
                                :small => "100x100",
                                :medium => "300x300"
                                }
 
  validates_attachment_content_type :doc, :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png', 'application/pdf'],
    :allow_nil => true

  validates_presence_of :description
  
end
