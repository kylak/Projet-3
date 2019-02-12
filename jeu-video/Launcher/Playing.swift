//
//  Playing.swift
//  jeu-video
//
//  Created by Gustav Berloty on 28/01/2019.
//  Copyright © 2019 Gustav Berloty. All rights reserved.
//

import Foundation

class Playing {
    
    var gameInformations : Game
    var winner : Player?
    
    init (game : Game) {
        gameInformations = game
        winner = nil
    }
    
    func start() {
        // Pour l'instant, l'ordre du jeu se fait selon les indices du tableau de players
        var indexOfThePlayingPlayer : Int = 0 // I'd like to declare this variable in the while because I won't use it anymore after the while, how can I do ?
        repeat {
            turn(of: nextPlayerIndex(after: indexOfThePlayingPlayer)) // The player associated has to play ! It's his turn.
            indexOfThePlayingPlayer = nextPlayerIndex(after: indexOfThePlayingPlayer)
        } while(!gameEnded())
        winner = getTheWinner()
        print("\n\(winner!.pseudo) a remporté la partie !\n")
    }
    
    func turn(of currentPlayer : Int) {
        let thePlayingPlayer : Player = gameInformations.players[currentPlayer]
        print("---- C'est au tour de \(thePlayingPlayer.pseudo) ----")
        let theNextPlayingPlayer : Player = gameInformations.players[nextPlayerIndex(after: currentPlayer)]
        print("\(thePlayingPlayer.pseudo), choisisez un personnage de votre équipe pour guérir un de ses confrères ou alors pour combattre un personnage adverse: ")
        let theFirstChosenCharacter : Character = chooseOneCharacter(among: charactersAlive(fromThisTeam: thePlayingPlayer.team) )!
        var theSecondChosenCharacter : Character
        if (String(describing: type(of: theFirstChosenCharacter)) == "Mage") {
            print("\(thePlayingPlayer.pseudo), choisisez un personnage de votre équipe que le mage guérira: ")
            theSecondChosenCharacter = chooseOneCharacter(among: charactersAlive(fromThisTeam: thePlayingPlayer.team) )!
        }
        else {
            print("\(thePlayingPlayer.pseudo), choisisez à présent un personnage de l'équipe de \(theNextPlayingPlayer.pseudo) à combattre: ")
            theSecondChosenCharacter = chooseOneCharacter(among: charactersAlive(fromThisTeam: theNextPlayingPlayer.team) )!
        }
        act(from: theFirstChosenCharacter, to: theSecondChosenCharacter)
    }
    
    func chooseOneCharacter(among players: [Character]) -> Character? {
        var index : Int = 1
        for i in players {
            print("- Entrez '\(index)' pour choisir le personnage suivant: ")
            print("\t- \(i.name), de type " + String(describing: type(of: i)) + ":")
            print("\t\t• \(i.LifePoint) de point de vie.")
            print("\t\t• \(i.DefensePoint) point de défense.") // Display the list of the types of character available
            if (i.weaponForCombat != nil) {
                print("\t\t• Arme(s):")
                print("\t\t\t› " + String(describing: type(of: i.weaponForCombat!)) + ":")
                print("\t\t\t\t- Dégat: \(i.weaponForCombat!.damage)")
                /*
                 print("\t\t\t- Pouvant être utilisé seulement par les personnages de type: ") // typeOfCharacterAuthorized
                 print("\t\t\t- Niveau minimum pour être utilisé:") // levelMinimumAuthorized
                 print("\t\t\t- Prix:") // price
                */
            }
            else { print("\t\t• Sans armes") }
            if (i.power != nil) {
                print("\t\t• Pouvoir(s):") // display any power information
                print("\t\t\t› \(i.power!.name):")
                if(i.power!.giveLifePoint != nil) {
                    print("\t\t\t\t- Ajoute \(i.power!.giveLifePoint!) points de vie.")
                }
                else { print("\t\t\t\t- N'ajoute pas de point de vie.") }
                if(i.power!.giveDefensePoint != nil) {
                    print("\t\t\t\t- Ajoute \(i.power!.giveLifePoint!) points de défense.")
                }
                else { print("\t\t\t\t- N'ajoute pas de point de défense.") }
                if(i.power!.giveDamage != nil) {
                    print("\t\t\t\t- Dommage: \(i.power!.giveDamage!)")
                }
                else { print("\t\t\t\t- Ne fait pas de dommage") }
            }
            else { print("\t\t• Sans pouvoirs") }
            index += 1
        }
        var indexer : Int?
        indexer =  Int(readLine()!)  // The user chooses one of thoses previously shown types
        while indexer == nil || indexer! > players.count || indexer! < 1 {
            print("Veuillez entrer un chiffre correspondant à un des personnages ci-dessus: ")
            indexer =  Int(readLine()!)
        }
        print("\(players[indexer! - 1].name) a été choisi.")
        return players[indexer! - 1]
    }
    
    func nextPlayerIndex (after this : Int) -> Int {
        if(this == gameInformations.players.count - 1) {
            return 0
        }
        return this + 1
    }
    
    func act (from: Character, to: Character) {
        if (String(describing: type(of: from)) == "Mage") { // It heals
            if (to.currentLifePoint < to.LifePoint) {
                if (from.power != nil && from.power!.giveLifePoint != nil) {
                    to.currentLifePoint += from.power!.giveLifePoint!
                    print("-> \(from.name) a ajouté \(from.power!.giveLifePoint!) points de vie à \(to.name).")
                }
            }
            else {
                print("-> \(to.name) a déjà tous ses points de vie.")
            }
            if (to.currentDefensePoint < to.DefensePoint) {
                if (from.power != nil && from.power!.giveDefensePoint != nil) {
                    to.currentDefensePoint += from.power!.giveDefensePoint!
                    print("-> \(from.name) a ajouté \(from.power!.giveDefensePoint!) points de défense à \(to.name).\n")
                }
            }
            else {
                print("-> \(to.name) a déjà tous ses points de défense.\n")
            }
        }
        else { // It fights
            if (from.weaponForCombat != nil) {
                if (from.weaponForCombat!.damage < to.LifePoint) {
                    to.LifePoint -= from.weaponForCombat!.damage
                    print("-> \(from.name) a ôté \(from.weaponForCombat!.damage) point de vie à \(to.name).\n")
                }
                else {
                    to.LifePoint = 0
                    print("-> \(from.name) a achevé \(to.name).")
                }
            }
            else { // For example with the Colosse character (he doesn't fight)
                print("-> \(from.name) n'a ôté aucun point de vie à \(to.name) car aucune arme de combat n'a été trouvé sur \(from.name).\n")
            }
        }
    }
    
    func isAllDead (team: [Character]) -> Bool {
        for char in team {
            if (char.LifePoint > 0) {
                return false
            }
        }
        return true
    }
    
    func charactersAlive (fromThisTeam teamGiven: [Character]) -> [Character] {
        var teamAlive : [Character] = []
        for char in teamGiven {
            if (char.LifePoint > 0) {
                teamAlive.append(char)
            }
        }
        return teamAlive
    }
    
    func gameEnded () -> Bool {
        var NbrOfUnplayablePlayer : Int = 0
        for player in gameInformations.players {
            if (isAllDead(team: player.team)) {
                 NbrOfUnplayablePlayer += 1
            }
        }
        if (NbrOfUnplayablePlayer == gameInformations.players.count - 1) {
            return true
        }
        return false
    }
    
    func getTheWinner () -> Player? {
        if (gameEnded()) {
            for player in gameInformations.players {
                if (!isAllDead(team: player.team)) {
                   return player
                }
            }
        }
        return nil
    }
    
}
