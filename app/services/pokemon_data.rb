class PokemonData

  def initialize(identifier)
    @identifier = identifier
  end

  def execute
    @identifier = @identifier.to_s
    begin
      if @identifier.to_i.to_s == @identifier
        response = RestClient.get("https://pokeapi.co/api/v2/pokemon/#{@identifier}/")
      else
        response = RestClient.get("https://pokeapi.co/api/v2/pokemon/#{@identifier.downcase}/")
      end

      pokemon_data = JSON.parse(response.body)
      return pokemon_data
    rescue RestClient::ExceptionWithResponse => e
      Rails.logger.error("Error getting Pokémon data: #{e.response}, #{response}")
      return nil
    end
  end
end
