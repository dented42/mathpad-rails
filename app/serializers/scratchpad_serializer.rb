class ScratchpadSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :lines

  belongs_to :user
end
