//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Neel Khattri on 8/5/16.
//  Copyright © 2016 SimpleStuff. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var mainDescription: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexIdLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var baseAttackLabel: UILabel!
    @IBOutlet weak var evolutionLabel: UILabel!
    @IBOutlet weak var currentEvolution: UIImageView!
    @IBOutlet weak var nextEvolution: UIImageView!
    
    
    var pokemon: Pokemon!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        pokemonName.text = "\(pokemon.name.capitalizedString)"
        
        let image = UIImage(named: "\(pokemon.pokedexId)")
        mainImage.image = image
        currentEvolution.image = image
        
        pokemon.pokemonDetails {
            self.updateUI()
        }

    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func updateUI () {
        mainDescription.text = pokemon.description
        typeLabel.text = pokemon.type
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        baseAttackLabel.text = pokemon.attack
        
        let pokedexIdString = String(pokemon.pokedexId)
        
        pokedexIdLabel.text = pokedexIdString
        
        if pokemon.nextEvolutionId == "" {
            evolutionLabel.text = "No evolutions"
            nextEvolution.hidden = true
        }
        else {
            nextEvolution.hidden = false
            nextEvolution.image = UIImage(named: pokemon.nextEvolutionId)
            var string = "Next Evolution: \(pokemon.nextEvolutionText)"
            if pokemon.nextEvolutionLevel != "" {
                string += " LVL \(pokemon.nextEvolutionLevel)"
            }
            evolutionLabel.text = string
        }
    }
}
