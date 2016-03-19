//
//  ViewController.swift
//  pokeman
//
//  Created by Srikanth Adavalli on 3/16/16.
//  Copyright © 2016 Srikanth Adavalli. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collection : UICollectionView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemonArray = [Pokeman]()
    var searchPokemon = [Pokeman]()
    var inSearchPokemon = false
    var audioPlayer : AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.Done
        
//        titleLabel.font = UIFont(name: "PokemonSolidNormal", size: 29.0)
//        initAudio()
        parsePokemon()
    }
    
    func initAudio() {
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "mp3")!
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            audioPlayer.prepareToPlay()
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
        }
        
        catch let error as NSError {
            print(error.debugDescription)
        }
        
    }
    
    func parsePokemon( ) {
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        do {
            
            let csv = try CSV.init(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let pokeID = Int(row["id"]!)
                let name = row["identifier"]
                
                let poke = Pokeman(name: name!, pokeman_id: pokeID!)
                pokemonArray.append(poke)
            }

        }
        catch let error as NSError {
            print(error.debugDescription)
        }
        
        
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("pokemonCell", forIndexPath: indexPath) as? pokemonCell else {
            return UICollectionViewCell()
        }
        
        let pokemon : Pokeman!
        
        if inSearchPokemon {
            pokemon = searchPokemon[indexPath.row]
        }
        
        else {
            pokemon = pokemonArray[indexPath.row]
        }
        cell.configCell(pokemon)
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchPokemon {
            return searchPokemon.count
        }
        return pokemonArray.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let poke : Pokeman!
        
        if inSearchPokemon {
            poke = searchPokemon[indexPath.row]
        }
        else
        {
            poke = pokemonArray[indexPath.row]
        }
        
        performSegueWithIdentifier("PokemonVC", sender: poke)
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(110, 110)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == ""
        {
            inSearchPokemon = false
            view.endEditing(true)
            collection.reloadData()
        }
        else {
            inSearchPokemon = true
            let searchText = searchBar.text!.lowercaseString
            searchPokemon = pokemonArray.filter( { $0.name.rangeOfString(searchText) != nil })
            collection.reloadData()
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "PokemonVC"
        {
            guard let detailVC = segue.destinationViewController as? PokemonVC else {
              return
            }
            
            guard let poke = sender as? Pokeman else {
                return
            }
            
            detailVC.pokemonName = poke
            
            
        }
    }
    
    @IBAction func pokemonMusic(sender: UIButton!) {
        if audioPlayer.playing == true
        {
            audioPlayer.stop()
            sender.alpha = 0.2
        }
        else {
            audioPlayer.play()
            sender.alpha = 1
        }
    }


}

