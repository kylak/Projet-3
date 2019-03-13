//
//  Character.swift
//  jeu-video
//
//  Created by Gustav Berloty on 02/01/2019.
//  Copyright © 2019 Gustav Berloty. All rights reserved.
//

import Foundation

class Character {       // This class is the character's class mother.

    // MARK: PROPERTY LIST
    
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
    
    // MARK: GETTER LIST
    
    func getName() -> String {   // a getter method
        return name
    }
    
    func getLifePoint() -> Int {     // a getter method
        return LifePoint
    }
    
    func geDefense() -> Int {    // a getter method
        return DefensePoint
    }
    
    func getCurrentLifePoint() -> Int {      // a getter method
        return currentLifePoint
    }
    
    func getCurrentDefensePoint() -> Int {     // a getter method
        return currentDefensePoint
    }
    
    func getWeapon() -> [Weapon?] {     // a getter method
        return weapon
    }
    
    func getWeapon(index : Int) -> Weapon? {      // a getter method
        if(index >= 0 && index < weapon.count){
            return weapon[index]
        }
        else {
            return nil
        }
    }

    func getWeaponUsedByDefault() -> Weapon? {       // a getter method
        return weaponUsedByDefault
    }
    
    func getPower() -> [Power?] {      // getter
        return power
    }
    
    func getPower(index : Int) -> Power? {      // a getter method
        if(index >= 0 && index < power.count){
            return power[index]
        }
        else {
            return nil
        }
    }
    
    func getPowerUsedByDefault() -> Power? {      // a getter method
        return powerUsedByDefault
    }
    
    // MARK: SETTER LIST
    
    func setWeaponUsedByDefault(this weap : Weapon?) {      // a setter method
        weaponUsedByDefault = weap
    }
    
    func setPowerUsedByDefault(this: Power?) {      // a setter method
        powerUsedByDefault = this
    }
    
    func addWeapon(this weap : Weapon?) {       // a kind of setter method
        weapon.append(weap)
    }
    
    func addPower(this powerGiven : Power?) {       // a kind of setter method
        power.append(powerGiven)
    }
    
    // MARK: CONSTRUCTOR
    
    init(name:String, life:Int, defense:Int){
        self.name = name
        LifePoint = life
        DefensePoint = defense
        currentLifePoint = LifePoint
        currentDefensePoint = DefensePoint
        self.weapon = []
        self.power = []
    }
    
    // MARK: ACTION METHODS
    
    // This function is used to make a character fighting or healing an other.
    func act(to: Character) -> Bool {       // It returns true only if a character dies.
        if (String(describing: type(of: self)) == "Mage") { // It heals
            return heal(to : to)
        }
        else { // It fights
            return fight(to : to)
        }
    }
    
    private func fight(to : Character) -> Bool {        // This function is used to make a character fighting
        if (weaponUsedByDefault != nil) {
            if (weaponUsedByDefault!.getDamage() < to.currentLifePoint) {
                to.currentLifePoint -= weaponUsedByDefault!.getDamage()
                print("-> \(name) a ôté \(weaponUsedByDefault!.getDamage()) point de vie à \(to.name).\n")
                return false
            }
            else {
                to.currentLifePoint = 0
                print(("-> \(name) a achevé \(to.name).").backgroundColor(.red))
                return true
            }
        }
        else { // For example with the Colosse character (he doesn't fight)
            print("-> \(name) n'a ôté aucun point de vie à \(to.name) car aucune arme de combat n'a été trouvé sur \(name).\n")
            return false
        }
    }
    
    private func heal(to : Character) -> Bool {     // This function is used to make a character healing
        if (to.currentLifePoint < to.LifePoint) {
            if (powerUsedByDefault != nil && powerUsedByDefault!.getGiveLifePoint() != nil) {
                to.currentLifePoint += powerUsedByDefault!.getGiveLifePoint()!
                print("-> \(name) a ajouté \(powerUsedByDefault!.getGiveLifePoint()!) points de vie à \(to.name).")
            }
        }
        else {
            print("-> \(to.name) a déjà tous ses points de vie.")
        }
        if (to.currentDefensePoint < to.DefensePoint) {
            if (powerUsedByDefault != nil && powerUsedByDefault!.getGiveDefensePoint() != nil) {
                to.currentDefensePoint += powerUsedByDefault!.getGiveDefensePoint()!
                print("-> \(name) a ajouté \(powerUsedByDefault!.getGiveDefensePoint()!) points de défense à \(to.name).\n")
            }
            return false
        }
        else {
            print("-> \(to.name) a déjà tous ses points de défense.\n")
            return false
        }
    }
    
     // MARK: OTHER
    
    func describe() {       // This function is used to describe the caracterics of the character.
        print("\t\t\t- \(name), de type " + String(describing: type(of: self)) + ":")
        print("\t\t\t\t• \(currentLifePoint) de point de vie.")
        print("\t\t\t\t• \(currentDefensePoint) point de défense.")
    }
}
