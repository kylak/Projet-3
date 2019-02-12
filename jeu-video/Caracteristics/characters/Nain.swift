//
//  Nain.swift
//  jeu-video
//
//  Created by Gustav Berloty on 02/01/2019.
//  Copyright © 2019 Gustav Berloty. All rights reserved.
//

import Foundation

class Nain:Character {
    
    // "Sa hache vous infligera beaucoup de dégâts, mais il n'a pas beaucoup de points de vie."
    
    init(name:String) {
        super.init(name:name, life:40, defense: 100)
        weapon.append(Axe(damage: 25, levelMinimumAuthorized: 1, price: 0))
        weaponForCombat = weapon[0]
    }
}
