class Scratchpad < ActiveRecord::Base
  belongs_to :user

  validates :title, :presence => true
  validates :description, :presence => true
  validates :user, :presence => true
end
