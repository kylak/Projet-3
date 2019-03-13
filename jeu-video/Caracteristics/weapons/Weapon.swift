//
//  Weapon.swift
//  jeu-video
//
//  Created by Gustav Berloty on 02/01/2019.
//  Copyright © 2019 Gustav Berloty. All rights reserved.
//

import Foundation

class Weapon {      // This class is the weapon's class mother.
    
    // MARK: PROPERTY LIST
    
    private var damage:Int       // The damage point it hurts.
    private var typeOfCharacterAuthorized: [Character]      // Whose can carry this weapon.
    private var levelMinimumAuthorized:Int      // What is the minimum level for carry this weapon.
    private var price:Int       // The price of this weapon (unused at that time).
    
    // MARK: GETTER LIST
    
    func getDamage() -> Int {
        return damage
    }
    
    // MARK: CONSTRUCTOR
    
    init(damage:Int, typeOfCharacterAuthorized:[Character], levelMinimumAuthorized:Int, price:Int) {
        self.damage = damage
        self.typeOfCharacterAuthorized = typeOfCharacterAuthorized
        self.levelMinimumAuthorized = levelMinimumAuthorized
        self.price = price
    }
    
    // MARK: ACTION METHOD
    
    static func generateNewOne () -> Weapon {       // Create a new power of healing, used for the treasure.
        let randomDamage : Int = Int.random(in: 2 ..< 41)
        return Weapon(damage: randomDamage, typeOfCharacterAuthorized: [], levelMinimumAuthorized:0, price:0)
    }
    
    // MARK: OTHER
    
    func describe() {       // This function is used to describe the caracterics of the weapon.
        print("\t\t\t\t\t› " + String(describing: type(of: self)) + ":")
        print("\t\t\t\t\t\t- Dégat: \(self.damage)")
    }
}
