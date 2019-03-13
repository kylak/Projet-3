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
        super.init(name:name, life:30, defense: 100)
        let healing : Power = Power(name: "Guérison")
        healing.setGiveLifePoint(this: 10)
        healing.setGiveDefensePoint(this: 2)
        addPower(this: healing)
        setPowerUsedByDefault(this: getPower(index: 0)) // healing
    }
}
