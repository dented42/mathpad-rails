class Scratchpad < ActiveRecord::Base
  belongs_to :user
  has_many :lines

  validates :title, :presence => true
  validates :description, :presence => true
  validates :user, :presence => true

  def ordered_lines
    self.lines.rank(:order)
  end
  
end
