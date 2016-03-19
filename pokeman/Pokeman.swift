//
//  pokemanC.swift
//  pokeman
//
//  Created by Srikanth Adavalli on 3/16/16.
//  Copyright © 2016 Srikanth Adavalli. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Pokeman {
    private var _name = String()
    private var _pokeman_id = Int()
    private var _pokemonURL = String()
//    private var _weight = String()
//    private var _height = String()
    private var _weight : String!
    private var _height : String!
    private var _defense : String!
    private var _attack : String!
    
    var name : String {
        if _name == ""
        {
            _name = ""
        }
        return _name
    }
    var weight : String {
        if _weight == nil
        {
            _weight = ""
        }
        return _weight
    }
    var height : String {
        if _height == nil
        {
            _height = ""
        }
        return _height
    }
    var defense : String	 {
        if _defense == nil
        {
            _defense = ""
        }
        return _defense
    }
    var attack : String {
        if _attack == nil
        {
            _attack = ""
        }
        return _attack
    }
    var pokeman_id : Int {
        return _pokeman_id
    }
    
    init(name: String, pokeman_id: Int)
    {
        self._name = name
        self._pokeman_id = pokeman_id
        
        _pokemonURL = "\(_BASE_URL)\(_POKEMON_URL)\(self.pokeman_id)"
        
    }
    
    func downloadPokemonDetails(completed : DownloadComplete) {
        
        let url = NSURL(string: _pokemonURL)!
//        let url = NSURL(string: "http://pokeapi.co/api/v2/pokemon/3")!
        Alamofire.request(.GET, url).responseJSON { responseObject in
            let result = responseObject.result
            guard let dict = result.value as? [String:AnyObject] else {
                return
            }
            
            print(dict)
            guard let weight = dict["weight"]?.stringValue, let height = dict["height"]?.stringValue
//                let defense = dict["defense"]?.stringValue
            
//                let attack = dict["attack"]?.stringValue
                else {
               return
            }
//            self._defense = defense
//            self._attack = attack
            self._weight = weight 
            self._height = height
            completed()
//            self._defense = defense
//            self._attack = attack
//            print(attack)
//            print(defense)
            print(height)
            print(weight)
        }
//        completed()
    }
}
