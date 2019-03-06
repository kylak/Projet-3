//
//  Power.swift
//  jeu-video
//
//  Created by Gustav Berloty on 02/01/2019.
//  Copyright © 2019 Gustav Berloty. All rights reserved.
//

import Foundation

class Power {       // This class is for all power a mage could have.
    
    let name : String       // The name of the power
    var giveDamage: Int?        // The damage point it may hurts.
    var giveLifePoint: Int?     // The life point it may give.
    var giveDefensePoint: Int?      // The defense point it may give.
    
    init(name: String) {
        self.name = name
    }
    
    func describe() {        // This function is used to describe the caracterics of the power.
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
    
    static func generateNewHealing () -> Power {         // Create a new power of healing, used for the treasure.
        let newPower : Power = Power(name: "Guérison++")    // The new power which will be returned.
        newPower.giveDefensePoint = Int.random(in: 2 ..< 41)
        newPower.giveLifePoint = Int.random(in: 2 ..< 41)
        return newPower
    }
    
}
