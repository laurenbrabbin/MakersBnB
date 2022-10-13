require 'space'
require 'space_repository'
require 'space_params'

RSpec.describe SpaceParams do
  describe "#name_contains_incorrect_characters?" do
    context "given a valid name" do
      it "returns false" do
        space_params = SpaceParams.new('space', 'Flat in london', '100')
        expect(space_params.name_contains_incorrect_characters?).to eq(false)
      end
    end
    context "given a invalid name" do
      it "returns true" do
        space_params = SpaceParams.new('space* <', 'flat in london', '100')
        expect(space_params.name_contains_incorrect_characters?).to eq(true)
      end
    end
  end
  describe "#description_contains_incorrect_characters?" do
    context "given a valid description" do
      it "returns false" do
        space_params = SpaceParams.new('space', 'Flat in london', '100')
        expect(space_params.description_contains_incorrect_characters?).to eq(false)
      end
    end
    context "given a invalid description" do
      it "returns true" do
        space_params = SpaceParams.new('space', 'flat in ><london', '100')
        expect(space_params.description_contains_incorrect_characters?).to eq(true)
      end
    end
  end
  describe "#incorrect_pricing?" do
    context "given a invalid price" do
      it "returns true" do
        space_params = SpaceParams.new('space', 'flat in london', '10H')
        expect(space_params.incorrect_pricing?).to eq(true)
      end
    end
    context "given a valid price" do
      it "returns true" do
        space_params = SpaceParams.new('space', 'flat in london', '100')
        expect(space_params.incorrect_pricing?).to eq(false)
      end
    end
  end
end