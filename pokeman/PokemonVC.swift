//
//  PokemonVC.swift
//  pokeman
//
//  Created by Srikanth Adavalli on 3/17/16.
//  Copyright © 2016 Srikanth Adavalli. All rights reserved.
//

import UIKit

class PokemonVC: UIViewController {
    
    @IBOutlet weak var pokemonTitleLabel : UILabel!
    @IBOutlet weak var pokemonImg: UIImageView!
    @IBOutlet weak var pokemonDescriptionLbl: UILabel!
    @IBOutlet weak var defLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var pokedexIDLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    var pokemonName : Pokeman!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonName.downloadPokemonDetails { () -> () in
            self.updateUI()
        }
    }
    
    func updateUI() {
        pokemonTitleLabel.text = pokemonName.name.capitalizedString
        pokemonImg.image = UIImage(named: "\(pokemonName.pokeman_id)")
        defLbl.text = pokemonName.defense
        baseAttackLbl.text = pokemonName.attack
        heightLbl.text = pokemonName.height
        weightLbl.text = pokemonName.weight
        pokedexIDLbl.text = String(pokemonName.pokeman_id)
    }
}
