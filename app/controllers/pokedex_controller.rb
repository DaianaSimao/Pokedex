# app/controllers/pokedex_controller.rb

class PokedexController < ApplicationController
  def index
    @search_term = params[:term]
    if @search_term.present?
      pokemon_data = PokemonData.new(@search_term)
      pokemon_data = pokemon_data.execute

      if pokemon_data
        pokemon_description = PokemonDescription.new(pokemon_data['id'])
        pokemon_description = pokemon_description.execute
        @pokemon = data(pokemon_data, pokemon_description)
      else
        flash[:alert] = "Pokémon not found."
        redirect_to root_path
      end
    else
      first_pokemon_data = PokemonData.new(1)
      first_pokemon_data = first_pokemon_data.execute
      first_pokemon_description = PokemonDescription.new(1)
      first_pokemon_description = first_pokemon_description.execute

      if first_pokemon_data
        @pokemon = data(first_pokemon_data, first_pokemon_description)
      else
        flash[:alert] = "Error getting Pokémon data."
        redirect_to pokedex_path
      end
    end
  end

  def data(pokemon_data, pokemon_description)
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
  end
end
