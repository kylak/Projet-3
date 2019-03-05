//
//  Power.swift
//  jeu-video
//
//  Created by Gustav Berloty on 02/01/2019.
//  Copyright © 2019 Gustav Berloty. All rights reserved.
//

import Foundation

class Power {
    
    let name : String
    var giveDamage: Int?
    var giveLifePoint: Int?
    var giveDefensePoint: Int?
    
    init(name: String) {
        self.name = name
    }
    
    func describe() {
        print("\t\t\t› \(name):")
        if(giveLifePoint != nil) {
            print("\t\t\t\t- Ajoute \(giveLifePoint!) points de vie.")
        }
        else { print("\t\t\t\t- N'ajoute pas de point de vie.") }
        if(giveDefensePoint != nil) {
            print("\t\t\t\t- Ajoute \(giveLifePoint!) points de défense.")
        }
        else { print("\t\t\t\t- N'ajoute pas de point de défense.") }
        if(giveDamage != nil) {
            print("\t\t\t\t- Dommage: \(giveDamage!)")
        }
        else { print("\t\t\t\t- Ne fait pas de dommage") }
    }
    
    static func generateNewOne () -> Power {
        let newPower : Power = Power(name: "Guérison++")
        newPower.giveDefensePoint = Int.random(in: 2 ..< 41)
        newPower.giveLifePoint = Int.random(in: 2 ..< 41)
        return newPower
    }
    
}
