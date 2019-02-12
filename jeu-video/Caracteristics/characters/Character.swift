//
//  Character.swift
//  jeu-video
//
//  Created by Gustav Berloty on 02/01/2019.
//  Copyright © 2019 Gustav Berloty. All rights reserved.
//

import Foundation

class Character {

    var name:String
    var LifePoint:Int
    var DefensePoint:Int
    
    var currentLifePoint:Int
    var currentDefensePoint:Int
    
    // For characters carrying weapon(s)
    var weapon : [Weapon?]
    var weaponForCombat : Weapon? // the weapon chosen for combat
    
    // For characters using power(s)
    var power : Power?
    
    // ( A character can have weapon(s) and power(s) )
    
    init(name:String, life:Int, defense:Int){
        self.weapon = []
        self.name = name
        LifePoint = life
        DefensePoint = defense
        currentLifePoint = LifePoint
        currentDefensePoint = DefensePoint
    }
}
