//
//  Axe.swift
//  jeu-video
//
//  Created by Gustav Berloty on 02/01/2019.
//  Copyright © 2019 Gustav Berloty. All rights reserved.
//

import Foundation

class Axe:Weapon { // An axe is an "hache" in french
    
    init(damage:Int, levelMinimumAuthorized:Int, price:Int){
        super.init(damage: damage, typeOfCharacterAuthorized: [], levelMinimumAuthorized: levelMinimumAuthorized, price: price)
    }
}
