require 'rails_helper'

RSpec.describe Breed, type: :model do

  it "is valid with valid attributes" do
    expect(Breed.new(name: 'Mane Coon')).to be_valid
  end

  it "is not valid with invalid attributes" do
    expect(Breed.new()).to_not be_valid
  end
end
