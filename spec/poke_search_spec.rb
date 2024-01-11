require 'rails_helper'

RSpec.describe 'PokeSearch', type: :request do
  describe "Test PokeSearch" do
    it "returns data of pokemon", :vcr do
      result = PokemonData.new("bulbasaur").execute
      expect(result).to be_truthy
    end
  end

  describe "Returns description of pokemon", :vcr do
    it "returns description of pokemon" do
      result = PokemonDescription.new("1").execute
      expect(result).to be_truthy
    end
  end
end
