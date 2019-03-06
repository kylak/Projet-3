//
//  Playing.swift
//  jeu-video
//
//  Created by Gustav Berloty on 28/01/2019.
//  Copyright © 2019 Gustav Berloty. All rights reserved.
//

import Foundation

class PlayTheGame {     // This class describe how the players play the game and how it works.
    
    var gameInformations : StartTheGame     // Get the players informations that have been captured with the game menu (see the cass StartTheGame.swift)
    var winner : Player?        // The future winner of the game.
    
    init (game : StartTheGame) {
        gameInformations = game
        winner = nil
    }
    
    func start() {      // The function that rules the game
        // At this time, the game order is in function of the players indexes.
        var indexOfThePlayingPlayer : Int = 0 // I'd like to declare this variable in the while because I won't use it anymore after the while, how can I do ?
        repeat {
            turn(of: nextPlayerIndex(after: indexOfThePlayingPlayer)) // The player associated has to play ! It's his turn.
            indexOfThePlayingPlayer = nextPlayerIndex(after: indexOfThePlayingPlayer)
        } while(!gameEnded())
        winner = getTheWinner()
        print("\n\(winner!.pseudo) a remporté la partie !\n")
    }
    
    func turn(of currentPlayer : Int) {     // This method describes how a player's turn works
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
    
    func nextPlayerIndex (after this : Int) -> Int {        // Give the next player index
        if(this == gameInformations.players.count - 1) {
            return 0
        }
        return this + 1
    }
    
    func gameEnded () -> Bool {     // Says if the game has ended
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
    
    func getTheWinner () -> Player? {       // Get the winner of the game
        if (gameEnded()) {
            for player in gameInformations.players {
                if (!player.isAllDead()) {
                   return player
                }
            }
        }
        return nil
    }
    
    func thisTimeIsGood() -> Bool {     // This method says if it's the time to show up a treasure or not.
        let number = Int.random(in: 0 ..< 4) // either 0, 1, 2 or 3
        if (number == 2) { return true } // 2 means it's a power
        return false
    }
    
}
