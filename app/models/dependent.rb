# == Schema Information
#
# Table name: dependents
#
#  id         :integer          not null, primary key
#  item_id    :integer
#  pn         :string(255)
#  model      :string(255)
#  note       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Dependent < ActiveRecord::Base
  belongs_to :item
end
