require 'rails_helper'

RSpec.describe Tag, type: :model do
  it "is valid with valid attributes" do
    breed = Breed.create(name:'Siamese')
    expect(Tag.new(name: 'Cuddly')).to be_valid
  end

  it "is not valid with invalid attributes" do
    expect(Tag.new()).to_not be_valid
  end
end
