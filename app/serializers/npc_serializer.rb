class NpcSerializer < ActiveModel::Serializer
  attributes :id, :name, :job, :quirk, :mood, :species, :alignment, :greeting
end
