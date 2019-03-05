//
//  Weapon.swift
//  jeu-video
//
//  Created by Gustav Berloty on 02/01/2019.
//  Copyright © 2019 Gustav Berloty. All rights reserved.
//

import Foundation

class Weapon {
    
    var damage:Int
    var typeOfCharacterAuthorized: [Character]
    var levelMinimumAuthorized:Int
    var price:Int
    
    init(damage:Int, typeOfCharacterAuthorized:[Character], levelMinimumAuthorized:Int, price:Int) {
        self.damage = damage
        self.typeOfCharacterAuthorized = typeOfCharacterAuthorized
        self.levelMinimumAuthorized = levelMinimumAuthorized
        self.price = price
    }
    
    func describe() {
        print("\t\t\t› " + String(describing: type(of: self)) + ":")
        print("\t\t\t\t- Dégat: \(self.damage)")
    }
    
    static func generateNewOne () -> Weapon {
        let randomDamage : Int = Int.random(in: 2 ..< 41)
        return Weapon(damage: randomDamage, typeOfCharacterAuthorized: [], levelMinimumAuthorized:0, price:0)
    }
    
}
