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
    @IBOutlet weak var move1: UILabel!
    @IBOutlet weak var move2: UILabel!
    @IBOutlet weak var move3: UILabel!
    @IBOutlet weak var move4: UILabel!
    @IBOutlet weak var move5: UILabel!
    @IBOutlet weak var stackViewMove: UIStackView!
    @IBOutlet weak var pokemonStackView: UIStackView!
    @IBOutlet weak var pokemonEvolutionStackView: UIStackView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet var evolutionView: UIView!
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var middle1StackView: UIStackView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var middleStackView2: UIStackView!
    @IBOutlet weak var bottomStackView: UIStackView!
    
    
    var pokemon: Pokemon!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        pokemon.pokemonDetails {
            self.updateUI()
        }
        pokemonName.text = "\(pokemon.name.capitalizedString)"
        
        let image = UIImage(named: "\(pokemon.pokedexId)")
        mainImage.image = image
        currentEvolution.image = image
        stackViewMove.hidden = true
        
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(PokemonDetailVC.handleSwipe(_:)))
        swipeGesture.direction = [.Right]
        self.view.addGestureRecognizer(swipeGesture)
    }
    
    func handleSwipe(sender: UISwipeGestureRecognizer) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func updateUI () {
        pokemonStackView.hidden = false
        topStackView.hidden = false
        middle1StackView.hidden = false
        middleStackView2.hidden = false
        bottomStackView.hidden = false
        lineView.hidden = false
        segmentedControl.hidden = false
        pokemonEvolutionStackView.hidden = false
        evolutionLabel.hidden = false
        evolutionView.hidden = false
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
        stackViewMove.hidden = true
    }
    func showMovesUI () {
        stackViewMove.hidden = false
        topStackView.hidden = true
        middle1StackView.hidden = true
        middleStackView2.hidden = true
        bottomStackView.hidden = true
        lineView.hidden = true
        pokemonEvolutionStackView.hidden = true
        evolutionLabel.hidden = true
        evolutionView.hidden = true
        segmentedControl.hidden = false
        move1.text = "Move 1: \(pokemon.move1)"
        move2.text = "Move 2: \(pokemon.move2)"
        move3.text = "Move 3: \(pokemon.move3)"
        move4.text = "Move 4: \(pokemon.move4)"
        move5.text = "Move 5: \(pokemon.move5)"
        
        if pokemon.move1 == "" {
            move1.hidden = true
        }
        if pokemon.move2 == "" {
            move2.hidden = true
        }
        if pokemon.move3 == "" {
            move3.hidden = true
        }
        if pokemon.move4 == "" {
            move4.hidden = true
        }
        if pokemon.move5 == "" {
            move5.hidden = true
        }
    }
    
    @IBAction func switchViews(sender: AnyObject) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            updateUI()
        case 1:
           showMovesUI()

        default:
            break;
        }
    }
    
}
