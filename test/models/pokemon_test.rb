require 'test_helper'

class PokemonTest < ActiveSupport::TestCase
    
    def pokemon_data(name)
        {name: name, type_1: "Water", hp: 5, attack: 5, defense: 5, sp_attack: 5, sp_defense: 5, speed: 5, generation: 1}
    end
    
    test "legendary should be set to false if no specified" do
        pokemon = Pokemon.create(pokemon_data("John Pokemon"))
        assert pokemon.save
        assert_not pokemon.legendary
    end

    test "stats total should be computed" do
        pokemon = Pokemon.create(pokemon_data("Joe Pokemon"))
        assert pokemon.save
        assert pokemon.stats_total == 30
    end

    test "pokemon type should be lowercased then capitalized" do
        data = pokemon_data("Barry")
        data[:type_1] = "wAtEr"

        pokemon = Pokemon.create(data)
        assert pokemon.save
        assert pokemon.type_1 == "Water"
    end 
    
    test "pokemon type 2 should be removed if it equals type 1" do
        data = pokemon_data("Barry")
        data[:type_1] = "wAtEr"
        data[:type_2] = "waTer"

        pokemon = Pokemon.create(data)
        assert pokemon.save
        assert pokemon.type_1 == "Water"
        assert pokemon.type_2.nil?
    end 

end
