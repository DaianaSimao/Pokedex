# app/controllers/pokedex_controller.rb

class PokedexController < ApplicationController
  def index
    @search_term = params[:term]
    if @search_term.present?
      pokemon_data = fetch_pokemon_data(@search_term)

      if pokemon_data
        pokemon_description = fetch_description_pokemon(pokemon_data['id'])
        @pokemon = {
          name: pokemon_data['name'].capitalize,
          abilities: pokemon_data['abilities'].map { |ability| ability['ability']['name'].capitalize },
          height: pokemon_data['height'],
          weight: pokemon_data['weight'],
          types: pokemon_data['types'].map { |type| type['type']['name'].capitalize },
          image_url: pokemon_data['sprites']['other']['dream_world']['front_default'],
          locais: pokemon_data['location_area_encounters'],
          moves: pokemon_data['moves'].map { |move| move['move']['name'].capitalize },
          description: pokemon_description.nil? ? "Featureless" : pokemon_description['descriptions'][7]['description'],
          status: pokemon_data['stats'].map { |status| { name: status['stat']['name'].capitalize, base_stat: status['base_stat'] } }
        }
      else
        flash[:alert] = "Pokémon não encontrado."
        redirect_to root_path
      end
    else
      # Lógica para exibir o primeiro Pokémon
      first_pokemon_data = fetch_pokemon_data(1)
      first_pokemon_description = fetch_description_pokemon(1)

      if first_pokemon_data
        @pokemon = {
          name: first_pokemon_data['name'].capitalize,
          abilities: first_pokemon_data['abilities'].map { |ability| ability['ability']['name'].capitalize },
          height: first_pokemon_data['height'],
          weight: first_pokemon_data['weight'],
          types: first_pokemon_data['types'].map { |type| type['type']['name'].capitalize },
          image_url: first_pokemon_data['sprites']['other']['dream_world']['front_default'],
          moves: first_pokemon_data['moves'].map { |move| move['move']['name'].capitalize },
          description: first_pokemon_description.nil? ? "Featureless" : first_pokemon_description['descriptions'][7]['description'],
          status: first_pokemon_data['stats'].map { |status| { name: status['stat']['name'].capitalize, base_stat: status['base_stat'] } }
        }
      else
        flash[:alert] = "Erro ao obter dados do primeiro Pokémon."
        redirect_to pokedex_path
      end
    end
  end

  private

  def fetch_pokemon_data(identifier)
    identifier = identifier.to_s
    begin
      if identifier.to_i.to_s == identifier
        response = RestClient.get("https://pokeapi.co/api/v2/pokemon/#{identifier}/")
      else
        response = RestClient.get("https://pokeapi.co/api/v2/pokemon/#{identifier.downcase}/")
      end

      pokemon_data = JSON.parse(response.body)
      return pokemon_data
    rescue RestClient::ExceptionWithResponse => e
      Rails.logger.error("Erro ao obter dados do Pokémon: #{e.response}, #{response}")
      return nil
    end
  end

  def fetch_description_pokemon(identifier)
    identifier = identifier.to_s
    begin
      response = RestClient.get("https://pokeapi.co/api/v2/characteristic/#{identifier}/")
      pokemon_description = JSON.parse(response.body)
      return pokemon_description
    rescue RestClient::ExceptionWithResponse => e
      Rails.logger.error("Erro ao obter dados do Pokémon: #{e.response}, #{response}")
      return nil
    end
  end
end
