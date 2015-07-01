class ScratchpadSerializer < ActiveModel::Serializer
  attributes :id, :title, :description

  belongs_to :user

  has_many :lines
  def lines
    object.ordered_lines.map.with_index(1) { |l,i| {position: i, line: l.content } }.to_a
  end
end
