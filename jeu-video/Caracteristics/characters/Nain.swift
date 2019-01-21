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
    
    var weapon:Axe
    
    init(name:String){
        self.weapon = Axe(damage: 25, levelMinimumAuthorized: 1, price: 0)
        super.init(name:name, life:40, defense: 100)
    }
}
