class PokemonDescription

  def initialize(pokemon)
    @pokemon = pokemon
  end

  def execute
    @pokemon = @pokemon.to_s
    begin
      response = RestClient.get("https://pokeapi.co/api/v2/characteristic/#{@pokemon}/")
      pokemon_description = JSON.parse(response.body)
      return pokemon_description
    rescue RestClient::ExceptionWithResponse => e
      Rails.logger.error("Error getting Pokémon data.: #{e.response}, #{response}")
      return nil
    end
  end
end
