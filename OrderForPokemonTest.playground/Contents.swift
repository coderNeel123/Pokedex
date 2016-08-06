//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


for var x = 1, x<=Int(row["order"]), x++ {
    for row in rows {
        if x = Int(row["order"]) {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemon.append(poke)
        }
    }
    x ++
}


for row in rows {
    let pokeId = Int(row["id"]!)!
    let name = row["identifier"]!
    let poke = Pokemon(name: name, pokedexId: pokeId)
    pokemon.append(poke)
}