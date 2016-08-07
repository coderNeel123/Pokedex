//
//  ViewController.swift
//  Pokedex
//
//  Created by Neel Khattri on 8/3/16.
//  Copyright © 2016 SimpleStuff. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var buttonTapped: UIButton!
    
    var pokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var isInSearchMode = false
    var filteredPokemon = [Pokemon]()
    var noPokemon = [Pokemon]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.Done
        parsePokemonCSV()
        
        beginAudio()
        
        
        buttonTapped.hidden = true
    
    
    }
    
    func handleTap() {
        view.endEditing(true)
        buttonTapped.hidden = true
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
            
            let poke: Pokemon!
            
            if isInSearchMode {
                poke = filteredPokemon[indexPath.row]
                }
            else {
                poke = pokemon[indexPath.row]
                searchBar.placeholder = "Search for Pokemon"
            }
            
            cell.configureCell(poke)
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PokemonDetailVC" {
            if let detailVC = segue.destinationViewController as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    detailVC.pokemon = poke
                }
            }
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let poke: Pokemon!
        
        if isInSearchMode {
            poke = filteredPokemon[indexPath.row]
        }
        else {
            poke = pokemon[indexPath.row]
        }
        
        performSegueWithIdentifier("PokemonDetailVC", sender: poke)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isInSearchMode {
            return filteredPokemon.count
        }
        return pokemon.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(105, 105)
    }
    
    func parsePokemonCSV () {
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for var x = 1; x<=779; x += 1 {
                for row in rows {
                    if x == Int(row["order"]!)! {
                        let pokeId = Int(row["id"]!)!
                        let name = row["identifier"]!
                        let poke = Pokemon(name: name, pokedexId: pokeId)
                        pokemon.append(poke)
                        break
                    }
                }
            }
            
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
    }
    
    @IBAction func musicButtonPressed(sender: UIButton!) {
        if musicPlayer.playing {
            musicPlayer.stop()
            sender.alpha = 0.2
        }
        else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
        
    }
    
    func beginAudio () {
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()

        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
            if searchBar.text == nil {
            isInSearchMode = false
            view.endEditing(true)
            collectionView.reloadData()
            searchBar.placeholder = "Search for Pokemon"
        }
        else {
            isInSearchMode = true
            buttonTapped.hidden = false
            let lower = searchBar.text!.lowercaseString
            filteredPokemon = pokemon.filter({$0.name.rangeOfString(lower) != nil})
            if searchBar.text == "" {
                filteredPokemon = pokemon
            }
            collectionView.reloadData()
            
        }
    }

    
    @IBAction func buttonTapped(sender: AnyObject) {
        handleTap()
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
        searchBar.placeholder = "Search for Pokemon"
        }

    
}

