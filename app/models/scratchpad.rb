class Scratchpad < ActiveRecord::Base
  belongs_to :user
  has_many :lines

  validates :title, :presence => true
  validates :description, :presence => true
  validates :user, :presence => true

  def ordered_lines
    lines = self.lines.rank(:order)
  end

  def consolidate_order(options = {})
    defaults = { :save? => true }
    options = defaults.merge(options)

    lines = self.lines.rank(:order)
    lines.each_with_index do | line, index |
      line.order = index
    end

    if options[:save?]
      Line.transaction do
        lines.each do | line | 
          line.save
        end
      end
    end
    
  end
  
end
