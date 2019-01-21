//
//  Power.swift
//  jeu-video
//
//  Created by Gustav Berloty on 02/01/2019.
//  Copyright © 2019 Gustav Berloty. All rights reserved.
//

import Foundation

class Power {
    
    let giveDamage: Int
    let giveLifePoint: Int
    let giveDefensePoint: Int
    
    init(damage: Int, life: Int, defense: Int) {
        giveDamage = damage
        giveLifePoint = life
        giveDefensePoint = defense
    }
    
}
