class Line < ActiveRecord::Base
  include RankedModel
  
  belongs_to :scratchpad
  ranks :order,
    :with_same => :scratchpad_id
  
  validates :scratchpad, :presence => true
  validates :content, :presence => true
  
end
