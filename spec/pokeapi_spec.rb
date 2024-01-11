# spec/requests/pokeapi_spec.rb
require 'rails_helper'
require 'net/http'

RSpec.describe 'PokeAPI', type: :request do
  describe 'GET /api/v2/pokemon/pikachu', :vcr do
    it 'returns a successful response' do
      uri = URI('https://pokeapi.co/api/v2/pokemon/pikachu')
      response = Net::HTTP.get_response(uri)
      expect(response.code).to eq '200'
    end
  end

  describe 'GET /api/v2/pokemon/pikachu', :vcr do
    it 'returns a body with the name Pikachu' do
      uri = URI('https://pokeapi.co/api/v2/pokemon/pikachu')
      response = Net::HTTP.get_response(uri)
      expect(JSON.parse(response.body)['name']).to eq 'pikachu'
    end
  end

  describe 'GET /api/v2/pokemon/1', :vcr do
    it 'returns a successful response' do
      uri = URI('https://pokeapi.co/api/v2/characteristic/1')
      response = Net::HTTP.get_response(uri)
      expect(response.code).to eq '200'
    end
  end

  describe 'GET /api/v2/pokemon/1', :vcr do
    it 'returns a body with the name Pikachu' do
      uri = URI('https://pokeapi.co/api/v2/characteristic/1')
      response = Net::HTTP.get_response(uri)
      expect(JSON.parse(response.body)['descriptions'][7]['description']).to eq 'Loves to eat'
    end
  end
end
