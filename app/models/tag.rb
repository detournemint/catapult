class Tag < ApplicationRecord
  has_many :breed_tags
  has_many :breeds, through: :breed_tags

  accepts_nested_attributes_for :breed_tags
  validates :name, presence: true
end
