class BreedSerializer < ActiveModel::Serializer
  attributes :id, :name, :tag_count, :tag_ids

  def tag_count 
    object.breed_tags.count
  end

  def tag_ids 
    object.breed_tags.pluck(:tag_id)
  end
end
