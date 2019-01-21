//
//  Game.swift
//  jeu-video
//
//  Created by Gustav Berloty on 02/01/2019.
//  Copyright © 2019 Gustav Berloty. All rights reserved.
//

import Foundation

class Game {
    
    var players : [Player]
    let nbrOfCharacterPerTeam : Int  = 3
    
    /* How the game init works :
        We add each player one per one (as many as we want)
        when we have finished to add the players, we leave the 'adding mode' using an alphanumeric character
        then we can launch the first round of the game.
    */
    
    init() {
        print("\nBienvenu dans ce jeu,\n")
        players = []
        addPlayers()
    }
    
    func addPlayers() {
        var command : String // First mod is adding, adding the player
        repeat {
            addPlayer()
            print("Si vous souhaitez ajouter un nouveau joueur, entrez 'n'. \nSinon entrez n'importe quelle autre valeur alphanumérique.\n")
            command = getGivenValue()
        } while (command == "n") // 'n' for new
    }
    
    func addPlayer() {
        print("Veuillez entrer votre nom de joueur: ")
        let pseudoPlayer : String = newPseudo() // The pseudo's player
        print("Vous avez à présent à créer \(nbrOfCharacterPerTeam) personnages pour constituer une équipe.")
        players[players.count] =  Player(name : pseudoPlayer, teamPlayer : createTeam())
        print("Ajout du joueur: " + pseudoPlayer + "terminé. \n")
    }
    
    func createTeam () -> [Character] {
        var teamPlayer : [Character] = []
        for _ in 1...nbrOfCharacterPerTeam { teamPlayer.append(createCharacter()) } // Create the (3) characters for the player's team
        return teamPlayer
    }
    
    func createCharacter() -> Character {
        var tmpCharacter : Character?
        print("Veuillez entrer le pseudo du personnage: ")
        let nameOfCharacter : String  = newPseudo()
        print("Choisisez le 'type' de ce personnage: \n- Entrez 1 pour un personnage de type COMBATTANT: L'attaquant classique, un bon guerrier !\n- Entrez 2 pour un personnage de type MAGE: Son talent ? Soigner les membres de son équipe.\n- Entrez 3 pour un personnage de type COLOSSE: Imposant et très résistant, mais il ne vous fera pas bien mal.\n- Entrez 4 pour un personnage de type NAIN: Sa hache vous infligera beaucoup de dégâts, mais il n'a pas beaucoup de points de vie.") // Display the list of the types of character available
        var indexer : Int?
        repeat {
            repeat { indexer =  Int(getGivenValue()) } while indexer == nil // The user chooses one of thoses previously shown types
            switch indexer! {
            case 1: tmpCharacter = Combattant(name: nameOfCharacter)
            case 2: tmpCharacter = Mage(name: nameOfCharacter)
            case 3: tmpCharacter = Colosse(name: nameOfCharacter)
            case 4: tmpCharacter = Nain(name: nameOfCharacter)
            default: print("Personnage choisi incconu, veillez recommencer") // In that case, the user entered a wrong number, so he has to give us a new one.
                break
            }
        } while(indexer! < 1 || indexer! > 4)
        return tmpCharacter!
    }
    
    func newPseudo() -> String {
        var pseudo : String
        repeat { pseudo = getGivenValue() } while !isUnique(given: pseudo)
        return pseudo
    }
    
    func getGivenValue() -> String {
        var name : String?
        while name == nil {name = readLine()}
        return name!
    }
    
    func isUnique(given : String) -> Bool {
        for one in players { if one.pseudo == given { return false } }
        return true
    }
    
}
