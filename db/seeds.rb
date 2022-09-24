# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

pokemons = CSV.read("./db/pokemon.csv")
pokemons_data = []
pokemons[1..].each do |id, name, ty1, ty2, total, hp, atk, df, sp_atk, sp_def, spd, gen, lg|
    pokemons_data.push({
        name: name,
        type_1: ty1,
        type_2: ty2,
        stats_total: total.to_i,
        hp: hp.to_i,
        attack: atk.to_i,
        defense: df.to_i,
        sp_attack: sp_atk.to_i,
        sp_defense: sp_def.to_i,
        speed: spd.to_i,
        generation: gen.to_i,
        legendary: lg == "True" ? true : false
    })
end

Pokemon.create(pokemons_data)
