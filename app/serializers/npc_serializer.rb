# frozen_string_literal: true

class NpcSerializer < ActiveModel::Serializer
  attributes :id, :name, :job, :quirk, :mood, :species, :alignment, :greeting
end
