# == Schema Information
#
# Table name: issues
#
#  id          :integer          not null, primary key
#  item_id     :integer
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Issue < ActiveRecord::Base
  belongs_to :item
end
