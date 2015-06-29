class LineSerializer < ActiveModel::Serializer
  attributes :id, :content, :order

  belongs_to :scratchpad
end
