//
//  pokemonCell.swift
//  pokeman
//
//  Created by Srikanth Adavalli on 3/16/16.
//  Copyright © 2016 Srikanth Adavalli. All rights reserved.
//

import UIKit

class pokemonCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbNailImage : UIImageView!
    @IBOutlet weak var thumbNailLabel : UILabel!
    
    var pokemon : Pokeman!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5
    }
    
    func configCell (pokemon : Pokeman)
    {
        self.pokemon = pokemon
        
        thumbNailLabel.text = pokemon.name.capitalizedString
        thumbNailImage.image = UIImage(named: "\(pokemon.pokeman_id)")
    }

}
