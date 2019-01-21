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
    
    init(name:String, life:Int, defense:Int){
        self.name = name
        LifePoint = life
        DefensePoint = defense
    }
}
