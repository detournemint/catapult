class TagSerializer < ActiveModel::Serializer
  attributes :id, :name, :breed_count, :breed_ids

  def breed_count 
    object.breed_tags.count
  end

  def breed_ids 
    object.breed_tags.pluck(:breed_id)
  end
end
