//
//  Pokemon.swift
//  Pokedex
//
//  Created by Neel Khattri on 8/4/16.
//  Copyright © 2016 SimpleStuff. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _baseAttack: String!
    private var _nextEvolutionText: String!
    private var _pokemonUrl: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    
    var name: String {
        get {
            return _name
        }
    }
    var pokedexId: Int {
        get {
            return _pokedexId
        }
    }
    var description: String {
        get {
            if _description == nil {
                _description = ""
            }
            return _description
        }
    }
    var type: String {
        get {
            if _type == nil {
                _type = ""
            }
            return _type
        }
    }
    var defense: String {
        get {
            if _defense == nil {
                _defense = ""
            }
            return _defense
        }
    }
    var height: String {
        get {
            if _height == nil {
                _height = ""
            }
            return _height
        }
    }
    var weight: String {
        get {
            if _weight == nil {
                _weight = ""
            }
            return _weight
        }
    }
    var attack: String {
        get {
            if _baseAttack == nil {
                _baseAttack = ""
            }
            return _baseAttack
        }
    }
    var nextEvolutionText: String {
        get {
            if _nextEvolutionText == nil {
                _nextEvolutionText = ""
            }
            return _nextEvolutionText
        }
    }
    var nextEvolutionId: String {
        get {
            if _nextEvolutionId == nil {
                _nextEvolutionId = ""
            }
            return _nextEvolutionId
        }
    }
    var nextEvolutionLevel: String {
        get {
            if _nextEvolutionLevel == nil {
                _nextEvolutionLevel = ""
            }
            return _nextEvolutionLevel
        }
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        _pokemonUrl = "\(urlBase)\(urlPokemon)\(self._pokedexId)"
 
    }
    
    func pokemonDetails (completed: downloadComplete) {
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON { (response) -> Void in
            let resultNeeded = response.result
            
            if let dict = resultNeeded.value  as? Dictionary<String, AnyObject> {
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let attack = dict["attack"] as? Int {
                    self._baseAttack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    if let type = types[0]["name"] {
                        self._type = type.capitalizedString
                    }
                    if types.count > 1 {
                        for var x = 1; x < types.count; x+=1 {
                            if let type = types[x]["name"] {
                                self._type! += "/\(type.capitalizedString)"
                            }
                        }
                    }
                }
                else {
                    self._type = ""
                }
                if let description = dict["descriptions"] as? [Dictionary<String, String>] where description.count > 0 {
                    if let url = description[0]["resource_uri"]{
                        let nsUrl = NSURL(string: "\(urlBase)\(url)")!
                        Alamofire.request(.GET, nsUrl).responseJSON(completionHandler: { (response) -> Void in
                            let results = response.result
                            
                            if let descriptionDictionary = results.value as? Dictionary<String, AnyObject> {
                                if let description = descriptionDictionary["description"] as? String {
                                    self._description = description
                                }
                            }
                            
                            completed()
                        })
                    }
                }
                else {
                    self._description = ""
                }
                if let evolution = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolution.count > 0 {
                    if let to = evolution[0]["to"] as? String {
                    if to.rangeOfString("mega") == nil {
                        if let string = evolution[0]["resource_uri"] as? String {
                                let newString = string.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let evolutionNumber = newString.stringByReplacingOccurrencesOfString("/", withString: "")
                                self._nextEvolutionId = evolutionNumber
                                self._nextEvolutionText = to
                            
                            
                            
                            if let level = evolution[0]["level"] as? Int {
                                self._nextEvolutionLevel = "\(level)"
                            }
                            }
                        }
                    }
                }
                
            }
        }
    }
        
}
    
