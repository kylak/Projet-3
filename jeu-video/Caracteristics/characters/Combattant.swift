//
//  Combattant.swift
//  jeu-video
//
//  Created by Gustav Berloty on 02/01/2019.
//  Copyright © 2019 Gustav Berloty. All rights reserved.
//

import Foundation

class Combattant:Character {        // This class represents combattant
    
    // "L'attaquant classique. Un bon guerrier !"

    init(name:String) {
        super.init(name:name, life:100, defense: 100)
        addWeapon(this: Sword(damage: 10, levelMinimumAuthorized: 1, price: 30))
        setWeaponUsedByDefault(this: getWeapon(index: 0))
    }
}
