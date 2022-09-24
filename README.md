# Poke API

Test technique pour PETAL

## Pokemon endpoint

| HTTP VERB  | Path      | Info      |
| ---------- | ----------|-----------|
| GET        | /pokemons | Return a list of pokemons. |
| GET        | /pokemons?page=:i&count=:j | Return a list of pokemons. Paginated using page & count |
| POST       | /pokemons | Create a new pokemon |
| GET        | /pokemons/:id | Returns the information of the pokemon with :id |
| PATCH/PUT  | /pokemons/:id | Updates the information of the pokemon with :id |
| DELETE     | /pokemons/:id | Deletes the pokemon with :id |

## POST/PUT Parameters

```json
{
    "pokemon": {
        "name": "TEST",
        "type_1": "Water", /* One of: ["Poison", "Flying", "Dragon", "Ground", "Fairy", "Grass", "Fighting", "Psychic", "Steel", "Ice", "Rock", "Dark", "Water", "Electric", "Fire", "Ghost", "Bug", "Normal"] */
        "type_2": "Fire",  /*Optional*/
        "hp": 5,
        "attack": 5,
        "defense": 5,
        "sp_attack": 5,
        "sp_defense": 5,
        "speed": 5,
        "generation": 1,
        "legendary": true  /*Optional, default false*/
    }
}
```

## Example



```sh
# Get
curl http://localhost:3000/pokemons/1
# Response: {"id":1,"name": "Bulbasaur", ...}

# Index
curl http://localhost:3000/pokemons?page=2&count=10
# Response: [{"id":11,"name": "Wartortle", ...}, ...]

# Create
curl -d '{"pokemon": {"name": "Sam","type_1": "Fire","hp": 20,"attack": 20,"defense": 20,"sp_attack": 20,"sp_defense": 20,"speed": 20,"generation": 1}}' -H "Content-Type: application/json" -X POST http://localhost:3000/pokemons/
# Response: {"status_text":"Pokemon created","id":804}
```
