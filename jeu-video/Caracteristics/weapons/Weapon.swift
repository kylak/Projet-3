//
//  Weapon.swift
//  jeu-video
//
//  Created by Gustav Berloty on 02/01/2019.
//  Copyright © 2019 Gustav Berloty. All rights reserved.
//

import Foundation

class Weapon {      // This class is the weapon's class mother.
    
    var damage:Int       // The damage point it hurts.
    var typeOfCharacterAuthorized: [Character]      // Whose can carry this weapon.
    var levelMinimumAuthorized:Int      // What is the minimum level for carry this weapon.
    var price:Int       // The price of this weapon (unused at that time).
    
    init(damage:Int, typeOfCharacterAuthorized:[Character], levelMinimumAuthorized:Int, price:Int) {
        self.damage = damage
        self.typeOfCharacterAuthorized = typeOfCharacterAuthorized
        self.levelMinimumAuthorized = levelMinimumAuthorized
        self.price = price
    }
    
    func describe() {       // This function is used to describe the caracterics of the weapon.
        print("\t\t\t› " + String(describing: type(of: self)) + ":")
        print("\t\t\t\t- Dégat: \(self.damage)")
    }
    
    static func generateNewOne () -> Weapon {       // Create a new power of healing, used for the treasure.
        let randomDamage : Int = Int.random(in: 2 ..< 41)
        return Weapon(damage: randomDamage, typeOfCharacterAuthorized: [], levelMinimumAuthorized:0, price:0)
    }
    
}
