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
    var weaponUsedByDefault : Weapon? // the weapon chosen for combat
    
    // For characters using power(s)
    var power : [Power?]
    var powerUsedByDefault : Power? // the power chosen for the fight time
    
    // ( A character can have weapon(s) and power(s) )
    
    init(name:String, life:Int, defense:Int){
        self.name = name
        LifePoint = life
        DefensePoint = defense
        currentLifePoint = LifePoint
        currentDefensePoint = DefensePoint
        self.weapon = []
        self.power = []
    }
    
    func describe() {
        print("\t- \(name), de type " + String(describing: type(of: self)) + ":")
        print("\t\t• \(currentLifePoint) de point de vie.")
        print("\t\t• \(currentDefensePoint) point de défense.")
    }
    
    func act(to: Character) {
        if (String(describing: type(of: self)) == "Mage") { // It heals
            heal(to : to)
        }
        else { // It fights
            fight(to : to)
        }
    }
    
    func fight(to : Character) {
        if (weaponUsedByDefault != nil) {
            if (weaponUsedByDefault!.damage < to.LifePoint) {
                to.currentLifePoint -= weaponUsedByDefault!.damage
                print("-> \(name) a ôté \(weaponUsedByDefault!.damage) point de vie à \(to.name).\n")
            }
            else {
                to.currentLifePoint = 0
                print("-> \(name) a achevé \(to.name).")
            }
        }
        else { // For example with the Colosse character (he doesn't fight)
            print("-> \(name) n'a ôté aucun point de vie à \(to.name) car aucune arme de combat n'a été trouvé sur \(name).\n")
        }
    }
    
    func heal(to : Character) {
        if (to.currentLifePoint < to.LifePoint) {
            if (powerUsedByDefault != nil && powerUsedByDefault!.giveLifePoint != nil) {
                to.currentLifePoint += powerUsedByDefault!.giveLifePoint!
                print("-> \(name) a ajouté \(powerUsedByDefault!.giveLifePoint!) points de vie à \(to.name).")
            }
        }
        else {
            print("-> \(to.name) a déjà tous ses points de vie.")
        }
        if (to.currentDefensePoint < to.DefensePoint) {
            if (powerUsedByDefault != nil && powerUsedByDefault!.giveDefensePoint != nil) {
                to.currentDefensePoint += powerUsedByDefault!.giveDefensePoint!
                print("-> \(name) a ajouté \(powerUsedByDefault!.giveDefensePoint!) points de défense à \(to.name).\n")
            }
        }
        else {
            print("-> \(to.name) a déjà tous ses points de défense.\n")
        }
    }
}
