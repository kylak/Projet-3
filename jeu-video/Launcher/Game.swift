//
//  Game.swift
//  jeu-video
//
//  Created by Gustav Berloty on 02/01/2019.
//  Copyright © 2019 Gustav Berloty. All rights reserved.
//

import Foundation

/*
 TODO:
 - Terminer l'unicité
- Message d'information
*/

class Game {
    
    var players : [Player]
    let minimumNbrOfPlayer : Int = 2
    let maximumNbrOfPlayer : Int = 2
    let nbrOfCharacterPerTeam : Int  = 3
    
    /* How the game init works :
        We add each player one per one (as many as we can)
        when we have finished to add the players, we leave the 'adding mode' using an alphanumeric character
        then we can launch the first round of the game.
    */
    
    init() {
        players = []
        
        func continueAfterPlayerAdded() {
            print("\nL'ajout de joueur est terminé.\nOnt été enregsitré les joueurs suivant: ")
            for tmp in players { print("- " + tmp.pseudo) }
            print("")
        }
        let frenchDetail: String
        if (minimumNbrOfPlayer == 1) { frenchDetail = "joueur"} else { frenchDetail = "joueurs" }
        if (minimumNbrOfPlayer == maximumNbrOfPlayer ) {
            print("\nBienvenue,\nCe jeu ne se joue qu'à \(minimumNbrOfPlayer) \(frenchDetail).")
            addPlayers()
            continueAfterPlayerAdded()
        }
        else if (maximumNbrOfPlayer == -1) { // -1 means that there's no maximum number of player
            print("\nBienvenue,\nCe jeu se joue à \(minimumNbrOfPlayer) \(frenchDetail) ou plus.")
            addPlayers()
            continueAfterPlayerAdded()
        }
        else if (minimumNbrOfPlayer < maximumNbrOfPlayer) {
            print("\nBienvenue,\nCe jeu se joue au minimum à \(minimumNbrOfPlayer) \(frenchDetail) et au maximum à \(maximumNbrOfPlayer).")
            addPlayers()
            continueAfterPlayerAdded()
        }
        else { print("\nErreur au niveau des caractéristiques du jeu.") }
    }
    
    func addPlayers() {
        
        var nbrPlayerCreated : Int = 0
        
        func addAditionalPlayer() -> Bool {
            print("\nSi vous souhaitez ajouter un nouveau joueur, entrez 'n'.\nSinon entrez n'importe quelle autre valeur alphanumérique.")
            let command : String = getGivenValue()
            if (command == "n") { // 'n' for new
                nbrPlayerCreated += 1
                print("\n## Ajout du \(nbrPlayerCreated)eme joueur ###")
                addPlayer()
                return true
            }
            return false
        }
        
        while (nbrPlayerCreated < minimumNbrOfPlayer) {
            var detail : String
            if( nbrPlayerCreated == 0 ) { detail = "er" } else { detail = "ème" }
            nbrPlayerCreated += 1
            print("\n## Ajout du \(nbrPlayerCreated)\(detail) joueur ###")
            addPlayer()
        }
        if (maximumNbrOfPlayer != -1) {
            while (nbrPlayerCreated < maximumNbrOfPlayer && addAditionalPlayer()){}
        }
        else { while(addAditionalPlayer()){} }
    }
    
    func addPlayer() {
        print("Veuillez entrer le nom du joueur:")
        let pseudoPlayer : String = newPseudo() // The pseudo's player
        print("\(pseudoPlayer) a à présent à créer \(nbrOfCharacterPerTeam) personnages pour constituer son équipe.")
        players.append(Player(name : pseudoPlayer, teamPlayer : createTeam()))
        print("\nLe joueur " + pseudoPlayer + " a été ajouté au jeu.\nVoici la constitution de son équipe:")
        for tmp in players[players.count-1].team {
           print("- " + tmp.name + ", " + String(describing: type(of: tmp)) + ".")
        }
    }
    
    func createTeam () -> [Character] {
        var teamPlayer : [Character] = []
        for i in 1...nbrOfCharacterPerTeam {
            var detail : String
            if( i==1 ) { detail = "er" } else { detail = "ème" }
            print("\n-- \(i)" + detail + " personnage -- ")
            teamPlayer.append(createCharacter()) } // Create the (3) characters for the player's team
        return teamPlayer
    }
    
    func createCharacter() -> Character {
        var tmpCharacter : Character?
        print("Veuillez entrer le pseudo du personnage: ")
        let nameOfCharacter : String  = newPseudo()
        print("Choisisez le 'type' de ce personnage: \n- Entrez 1 pour un personnage de type COMBATTANT: L'attaquant classique, un bon guerrier !\n- Entrez 2 pour un personnage de type MAGE: Son talent ? Soigner les membres de son équipe.\n- Entrez 3 pour un personnage de type COLOSSE: Imposant et très résistant, mais il ne vous fera pas bien mal.\n- Entrez 4 pour un personnage de type NAIN: Sa hache vous infligera beaucoup de dégâts, mais il n'a pas beaucoup de points de vie.") // Display the list of the types of character available
        var indexer : Int?
        repeat {
            indexer =  Int(readLine()!)  // The user chooses one of thoses previously shown types
            while indexer == nil {
                print("Veuillez entrer un chiffre correspondant à un des types ci-dessus: ")
                indexer =  Int(readLine()!)
            }
            switch indexer! {
            case 1: do {
                tmpCharacter = Combattant(name: nameOfCharacter)
                print("Le combattant \(nameOfCharacter) a été crée et sera ajouté à votre équipe.")
                }
            case 2: do {
                tmpCharacter = Mage(name: nameOfCharacter)
                print("Le mage \(nameOfCharacter) a été crée et sera ajouté à votre équipe.")
                }
            case 3: do {
                tmpCharacter = Colosse(name: nameOfCharacter)
                print("Le colosse \(nameOfCharacter) a été crée et sera ajouté à votre équipe.")
                }
            case 4: do {
                tmpCharacter = Nain(name: nameOfCharacter)
                print("Le nain \(nameOfCharacter) a été crée et sera ajouté à votre équipe.")
                }
            default: print("Veuillez entrer un chiffre correspondant à un des types ci-dessus: ") // In that case, the user entered a wrong number, so he has to give us a new one.
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
        name = readLine()
        while (name == nil || (name!).count < 3 || (name!).rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil) {
            print("Veuillez n'entrer que des caractères alphanumériques et 3 au minimum.")
            name = readLine()
        }
        return name!
    }
    
    func isUnique(given : String) -> Bool {
        for one in players {
            if one.pseudo == given {
                print("Le pseudo \(given) est déjà utilisé, veuillez en entrez un autre svp:")
                return false
            }
        }
        return true
    }
}
