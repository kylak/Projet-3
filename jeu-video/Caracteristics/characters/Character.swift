//
//  Character.swift
//  jeu-video
//
//  Created by Gustav Berloty on 02/01/2019.
//  Copyright © 2019 Gustav Berloty. All rights reserved.
//

import Foundation

class Character {       // This class is the character's class mother.

    private var name:String     // The character's name
    private var LifePoint:Int       // The total life point of the character
    private var DefensePoint:Int        // The total defense point of the character
    
    private var currentLifePoint:Int        // The current life point of the character
    private var currentDefensePoint:Int     // The current defense point of the character
    
    // For characters carrying weapon(s)
    private var weapon : [Weapon?]          // The weapon's inventory of the character
    private var weaponUsedByDefault : Weapon? // the weapon chosen for combat
    
    // For characters using power(s)
    private var power : [Power?]        // The power's inventory of the character
    private var powerUsedByDefault : Power? // the power chosen for the fight time
    
    // Getter
    
    func getName() -> String {  // getter
        return name
    }
    
    func getLifePoint() -> Int {    // getter
        return LifePoint
    }
    
    func geDefense() -> Int {   // getter
        return DefensePoint
    }
    
    func getCurrentLifePoint() -> Int { // getter
        return currentLifePoint
    }
    
    func getCurrentDefensePoint() -> Int {     // getter
        return currentDefensePoint
    }
    
    func getWeapon() -> [Weapon?] {     // getter
        return weapon
    }
    
    func getWeapon(index : Int) -> Weapon? {     // getter
        if(index >= 0 && index < weapon.count){
            return weapon[index]
        }
        else {
            return nil
        }
    }
    
    func addWeapon(this weap : Weapon) {  // Function to add one character to the player's team
        weapon.append(weap)
    }
    
    func getWeaponUsedByDefault() -> Weapon? {      // getter
        return weaponUsedByDefault
    }
    
    func setWeaponUsedByDefault(this weap : Weapon) {      // getter
        weaponUsedByDefault = weap
    }
    
    func getPower() -> [Power?] {      // getter
        return power
    }
    
    func getPower(index : Int) -> Power? {     // getter
        if(index >= 0 && index < power.count){
            return power[index]
        }
        else {
            return nil
        }
    }
    
    func addPower(this: Power?) {
        power.append(this)
    }
    
    func getPowerUsedByDefault() -> Power? {      // getter
        return powerUsedByDefault
    }
    
    func setPowerUsedByDefault(this: Power?) {
        powerUsedByDefault = this
    }
    
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
    
    func describe() {       // This function is used to describe the caracterics of the character.
        print("\t- \(name), de type " + String(describing: type(of: self)) + ":")
        print("\t\t• \(currentLifePoint) de point de vie.")
        print("\t\t• \(currentDefensePoint) point de défense.")
    }
    
    func act(to: Character) {       // This function is used to make a character fighting or healing an other.
        if (String(describing: type(of: self)) == "Mage") { // It heals
            heal(to : to)
        }
        else { // It fights
            fight(to : to)
        }
    }
    
    private func fight(to : Character) {        // This function is used to make a character fighting
        if (weaponUsedByDefault != nil) {
            if (weaponUsedByDefault!.getDamage() < to.LifePoint) {
                to.currentLifePoint -= weaponUsedByDefault!.getDamage()
                print("-> \(name) a ôté \(weaponUsedByDefault!.getDamage()) point de vie à \(to.name).\n")
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
    
    private func heal(to : Character) {     // This function is used to make a character healing
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
