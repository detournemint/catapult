class Breed < ApplicationRecord
  has_many :breed_tags, dependent: :destroy
  has_many :tags, through: :breed_tags

  accepts_nested_attributes_for :breed_tags
  
  validates :name, presence: true
end
