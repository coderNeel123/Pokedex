//
//  PokeCell.swift
//  Pokedex
//
//  Created by Neel Khattri on 8/4/16.
//  Copyright © 2016 SimpleStuff. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell (pokemon: Pokemon) {
        
        self.pokemon = pokemon
        
        label.text = self.pokemon.name.capitalizedString
        
        image.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }

    
}
