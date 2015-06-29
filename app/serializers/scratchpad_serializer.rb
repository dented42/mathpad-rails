class ScratchpadSerializer < ActiveModel::Serializer
  attributes :id, :title, :description

  belongs_to :user

  has_many :lines
  def lines
    object.ordered_lines #.pluck(:content)
  end
end
