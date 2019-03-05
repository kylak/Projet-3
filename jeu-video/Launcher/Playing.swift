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
        let theFirstChosenCharacter : Character = thePlayingPlayer.chooseOneCharacter(onlyAliveCharacter: true)!
        var theSecondChosenCharacter : Character
        
        if(thisTimeIsGood()){
            Treasure.appeared(for: theFirstChosenCharacter)
        }
        
        if (String(describing: type(of: theFirstChosenCharacter)) == "Mage") {
            print("\(thePlayingPlayer.pseudo), choisisez un personnage de votre équipe que le mage guérira: ")
            theSecondChosenCharacter = thePlayingPlayer.chooseOneCharacter(onlyAliveCharacter: true)!
        }
        else {
            print("\(thePlayingPlayer.pseudo), choisisez à présent un personnage de l'équipe de \(theNextPlayingPlayer.pseudo) à combattre: ")
            theSecondChosenCharacter = theNextPlayingPlayer.chooseOneCharacter(onlyAliveCharacter: true)!
        }
        theFirstChosenCharacter.act(to: theSecondChosenCharacter)
    }
    
    func nextPlayerIndex (after this : Int) -> Int {
        if(this == gameInformations.players.count - 1) {
            return 0
        }
        return this + 1
    }
    
    func gameEnded () -> Bool {
        var NbrOfUnplayablePlayer : Int = 0
        for thePlayerTeam in gameInformations.players {
            if (thePlayerTeam.isAllDead()) {
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
                if (!player.isAllDead()) {
                   return player
                }
            }
        }
        return nil
    }
    
    func thisTimeIsGood() -> Bool {
        // the use of thisTimeIsGood() is only to rename generateNewItem() to use it in the turn() method.
        return !generateNewItem() // ! i.e it's return more often a false value so get a treasure is less frequent that to not get one.
    }
    
    func generateNewItem () -> Bool { // True for weapon & False for power
        let number = Int.random(in: 0 ..< 4) // either 0, 1, 2 or 3
        if (number == 2) { return false } // 2 means it's a power
        return true
    }
    
}
