//
//  Player.swift
//  jeu-video
//
//  Created by Gustav Berloty on 02/01/2019.
//  Copyright © 2019 Gustav Berloty. All rights reserved.
//

import Foundation

class Player {
    
    var pseudo : String
    var team : [Character]

    init(name:String, teamPlayer : [Character]){
        pseudo = name
        team = teamPlayer
    }
}
