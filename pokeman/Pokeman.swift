//
//  pokemanC.swift
//  pokeman
//
//  Created by Srikanth Adavalli on 3/16/16.
//  Copyright © 2016 Srikanth Adavalli. All rights reserved.
//

import UIKit

class Pokeman {
    private var _name : String!
    private var _pokeman_id : Int!
    
    var name : String {
        return _name
    }
    var pokeman_id : Int {
        return _pokeman_id
    }
    
    init(name: String, pokeman_id: Int)
    {
        self._name = name
        self._pokeman_id = pokeman_id
    }

}
