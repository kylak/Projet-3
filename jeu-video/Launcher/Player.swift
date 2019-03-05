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
    
    func charactersAlive () -> [Character] {
        var teamAlive : [Character] = []
        for char in team {
            if (char.LifePoint > 0) {
                teamAlive.append(char)
            }
        }
        return teamAlive
    }
    
    func isAllDead () -> Bool {
        for char in team {
            if (char.LifePoint > 0) {
                return false
            }
        }
        return true
    }
    
    func chooseOneCharacter(onlyAliveCharacter : Bool) -> Character? {
        var teamChosen : [Character]
        if (onlyAliveCharacter == true) {
            teamChosen = charactersAlive()
        }
        else {
            teamChosen = team
        }
        describeTeam(teamGiven: teamChosen)
        var indexer : Int?
        indexer =  Int(readLine()!)  // The user chooses one of thoses previously shown types
        while indexer == nil || indexer! > teamChosen.count || indexer! < 1 {
            print("Veuillez entrer un chiffre correspondant à un des personnages ci-dessus: ")
            indexer =  Int(readLine()!)
        }
        print("\(teamChosen[indexer! - 1].name) a été choisi.")
        return teamChosen[indexer! - 1]
    }
    
    func describeTeam(teamGiven : [Character]) {
        var index : Int = 1
        for i in teamGiven {
            print("- Entrez '\(index)' pour choisir le personnage suivant: ")
            i.describe()
            if (i.weaponUsedByDefault != nil) {
                print("\t\t• Arme(s):")
                i.weaponUsedByDefault!.describe()
            }
            else { print("\t\t• Sans armes") }
            if (i.powerUsedByDefault != nil) {
                print("\t\t• Pouvoir(s):") // display any power information
                i.powerUsedByDefault!.describe()
            }
            else { print("\t\t• Sans pouvoirs") }
            index += 1
        }
    }
    
}
