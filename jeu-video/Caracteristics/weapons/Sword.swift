//
//  Sword.swift
//  jeu-video
//
//  Created by Gustav Berloty on 02/01/2019.
//  Copyright © 2019 Gustav Berloty. All rights reserved.
//

import Foundation

class Sword:Weapon {
    
    init(damage:Int, levelMinimumAuthorized:Int, price:Int) {
        let user:[Combattant] = []
        super.init(damage: damage, typeOfCharacterAuthorized: user, levelMinimumAuthorized: levelMinimumAuthorized, price: price)
    }
    
}
