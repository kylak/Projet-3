//
//  Combattant.swift
//  jeu-video
//
//  Created by Gustav Berloty on 02/01/2019.
//  Copyright © 2019 Gustav Berloty. All rights reserved.
//

import Foundation

class Combattant:Character {
    
    // "L'attaquant classique. Un bon guerrier !"

    init(name:String) {
        super.init(name:name, life:100, defense: 100)
        weapon.append(Sword(damage: 10, levelMinimumAuthorized: 1, price: 30))
        weaponUsedByDefault = weapon[0]
    }
}
