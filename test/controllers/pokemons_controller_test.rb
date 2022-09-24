require 'test_helper'

class PokemonsControllerTest < ActionDispatch::IntegrationTest
  
    def setup
        data = [["Joe", "Water"], ["Moe", "Fire"], ["Bro", "Flying"], ["Fish1", "Water"], ["Fish2", "Water"]]
        base = {hp: 5, attack: 5, defense: 5, sp_attack: 5, sp_defense: 5, speed: 5, generation: 1}
        data.each do |name, ty|
            base[:name] = name
            base[:type_1] = ty
            Pokemon.create(base)
        end
    end

    test "should create pokemon" do
        pokemon_data = {
            name: "Sam",
            type_1: "Fire",
            hp: 20,
            attack: 20,
            defense: 20,
            sp_attack: 20,
            sp_defense: 20,
            speed: 20,
            generation: 1
        }

        assert_difference("Pokemon.count") do
            post pokemons_path, params: { pokemon: pokemon_data }, as: :json
        end

        response = JSON.parse(@response.body)
        assert_equal "Pokemon created", response["status_text"]
        assert_equal "Sam", Pokemon.find(response["id"]).name
    end

    test "should fail to create pokemon" do
        pokemon_data = {
            name: "Sam",
            type_1: "Fire",
            hp: 0,
            attack: 20,
            defense: 20,
            sp_attack: 20,
            sp_defense: 20,
            speed: 20,
            generation: 1
        }

        post pokemons_path, params: { pokemon: pokemon_data }, as: :json

        response = JSON.parse(@response.body)
        assert_equal "Failed to create pokemon: Hp must be greater than 0", response["error"]
    end

    test "should delete pokemon" do
        joe = Pokemon.find_by(name: "Joe")
        delete pokemon_url(joe)

        response = JSON.parse(@response.body)

        assert_equal "Pokemon #{joe.id} deleted", response["status_text"]
        assert Pokemon.find_by(name: "Joe").nil?
    end

    test "should get pokemon" do
        joe = Pokemon.find_by(name: "Joe")
        get pokemon_url(joe)
        assert_equal joe.as_json, JSON.parse(@response.body)
    end

    test "should update pokemon" do
        moe = Pokemon.find_by(name: "Moe")
        patch pokemon_url(moe), params: { pokemon: {legendary: true} }

        response = JSON.parse(@response.body)
        assert_equal "Pokemon #{moe.id} updated", response["status_text"]
        assert Pokemon.find_by(name: "Moe").legendary
    end

    test "should return pokemon update error" do
        moe = Pokemon.find_by(name: "Moe")
        patch pokemon_url(moe), params: { pokemon: {name: "Joe"} }

        response = JSON.parse(@response.body)
        assert_equal "Failed to update pokemon #{moe.id}: Name has already been taken", response["error"]
    end

    test "should list all pokemon" do
        get pokemons_url
        response = JSON.parse(@response.body);
        assert_equal Pokemon.count, response.length
    end

    test "should paginate pokemon" do
        get pokemons_url(page: 3, count: 2)
        response = JSON.parse(@response.body);

        assert_equal 2, response.length
    end

end
