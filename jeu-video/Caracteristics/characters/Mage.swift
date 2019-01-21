//
//  Mage.swift
//  jeu-video
//
//  Created by Gustav Berloty on 02/01/2019.
//  Copyright © 2019 Gustav Berloty. All rights reserved.
//

import Foundation

class Mage:Character {
    
    // "Son talent ? Soigner les membres de son équipe."
    
    var healing : Power
    
    init(name:String){
        healing = Power(damage: 0, life: 10, defense: 2)
        super.init(name:name, life:110, defense: 100)
    }
}
