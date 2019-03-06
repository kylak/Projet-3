//
//  Mage.swift
//  jeu-video
//
//  Created by Gustav Berloty on 02/01/2019.
//  Copyright © 2019 Gustav Berloty. All rights reserved.
//

import Foundation

class Mage:Character {      // This class represents a mage
    
    // "Son talent ? Soigner les membres de son équipe."
    
    init(name:String) {
        super.init(name:name, life:110, defense: 100)
        let healing : Power = Power(name: "Guérison")
        healing.giveLifePoint = 10
        healing.giveDefensePoint = 2
        addPower(this: healing)
        setPowerUsedByDefault(this: getPower(index: 0)) // healing
    }
}
