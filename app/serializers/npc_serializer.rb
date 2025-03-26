class NpcSerializer < ActiveModel::Serializer
  attributes :id, :name, :job, :quirk, :mood, :greeting

  def greeting
    "Greetings, I am #{object.name}, your humble #{object.job}!"
  end
end
