class PokemonsController < ApplicationController

    def index
        page = params[:page]
        count = params[:count]

        if count.present?
            page = page ? page.to_i : 1
            count = count.to_i

            pokemons = Pokemon.all.page(page).per(count)
            render json: pokemons.to_json, status: :ok, adapter: :json
            return
        end

        render json: Pokemon.all.to_a.as_json, status: :ok, adapter: :json
    end

    def show
        pokemon = find_pokemon
        if pokemon.present?
            render json: pokemon.as_json, status: :ok, adapter: :json
        else
            render json: {error: "No pokemon with ID #{params[:id]}"}, status: :not_found
        end
    end

    def create
        pokemon = Pokemon.new(pokemon_params)
        if pokemon.save
            render json: {status_text: "Pokemon created", id: pokemon.id}, status: :ok, adapter: :json
        else
            errors = pokemon.errors.full_messages.join(', ')
            render json: {error: "Failed to create pokemon: #{errors}"}, status: :unprocessable_entity, adapter: :json
        end
    end

    def destroy
        pokemon = find_pokemon
        if pokemon.present?
            pokemon.destroy!
            render json: {status_text: "Pokemon #{params[:id]} deleted"}, status: :ok, adapter: :json
        else
            render json: {error: "No pokemon with ID #{params[:id]}"}, status: :not_found
        end
    end

    def update
        pokemon = find_pokemon
        if pokemon.present?
            pokemon.update(pokemon_params)
            if pokemon.errors.present?
                errors = pokemon.errors.full_messages.join(', ')
                render json: {error: "Failed to update pokemon #{params[:id]}: #{errors}"}, status: :unprocessable_entity, adapter: :json
            else
                render json: {status_text: "Pokemon #{params[:id]} updated"}, status: :ok, adapter: :json
            end
        else
            render json: {error: "No pokemon with ID #{params[:id]}"}, status: :not_found
        end
    end

    private

    def find_pokemon
        Pokemon.find_by(id: params[:id])
    end

    def pokemon_params
        params.require(:pokemon).permit(:name, :type_1, :type_2, :hp, :attack, :defense, :sp_attack, :sp_defense, :speed, :generation, :legendary)
    end

end
