//
//  Game.swift
//  jeu-video
//
//  Created by Gustav Berloty on 02/01/2019.
//  Copyright © 2019 Gustav Berloty. All rights reserved.
//

import Foundation

class Game {
    
    /*
     Idea for improvement: add a view team option in the menu and also an other option to modify team.
    */
    
    /*
     Todo: Fragmenter davantage mon code, notamment createCharacter() … ?
    */
    
    var players : [Player]
    var playersAdded : Bool // used by the menu
    let minimumNbrOfPlayer : Int = 2
    let maximumNbrOfPlayer : Int = 2
    let nbrOfCharacterPerTeam : Int  = 3
    var playingTheGame : Playing?
    
    /* How the game init works :
     We add each player one per one (as many as we can)
     when we have finished to add the players, we leave the 'adding mode' using an alphanumeric character
     then we can launch the first round of the game.
     */
    
    init() {
        players = []
        playersAdded = false
        let frenchDetail: String

        if (minimumNbrOfPlayer == 1) { frenchDetail = "joueur"} else { frenchDetail = "joueurs" }
        if (minimumNbrOfPlayer == maximumNbrOfPlayer) {
            print("\nBienvenue dans le jeu lié au Projet 3.\nCe jeu ne se joue qu'à \(minimumNbrOfPlayer) \(frenchDetail).")
        }
        else if (maximumNbrOfPlayer == -1) { // -1 means that there's no maximum number of player
            print("\nBienvenue,\nCe jeu se joue à \(minimumNbrOfPlayer) \(frenchDetail) ou plus.")
        }
        else if (minimumNbrOfPlayer < maximumNbrOfPlayer) {
            print("\nBienvenue,\nCe jeu se joue de \(minimumNbrOfPlayer) à \(maximumNbrOfPlayer) joueurs.")
        }
        else {
            print("\nErreur au niveau des caractéristiques du jeu.");
            exit(0);
        }
        while(menu()) {}
    }
    
    func continueAfterPlayerAdded() {
        playersAdded = true
        print("L'ajout de joueur est terminé.\nOnt été enregsitré les joueurs suivant: ")
        for tmp in players { print("- " + tmp.pseudo) }
        print("")
    }
    
    func play () {
        playingTheGame = Playing(game: self)
        playingTheGame?.start()
    }
    
    func menu() -> Bool {
        if (!playersAdded) {
            print("\n### Menu du jeu ###\nPour:\n- Commencer une partie en ajoutant les joueurs et leurs personnages, entrez 'n'.\n- Avoir des informations sur le jeu, entrez 'i'.\n- Quitter le jeu, entrez n'importe quelle autre valeur alphanumérique.")
        }
        else {
            print("\n### Menu du jeu ###\nPour:\n- Lancer une partie, entrez 'l'.\n- Avoir des informations sur le jeu, entrez 'i'.\n- Quitter le jeu entrez n'importe quelle autre valeur alphanumérique.")
        }
        var option : String
        option = readLine()!
        if (option == "n"){ // 'n' for next
            print("\n### Ajout des joueurs ###")
            addPlayers()
            continueAfterPlayerAdded()
            return true;
        }
        else if (option == "l") {
            play()
        }
        else if (option == "i") {
            print("### Informations relatives au jeu ###\nhttps://openclassrooms.com/fr/projects/59/assignment")
            return true;
        }
        else { exit(0); }
        return false;
    }
    
    func addPlayers() {
        var nbrPlayerCreated : Int = 0
        
        while (nbrPlayerCreated < minimumNbrOfPlayer) {
            var detail : String
            if( nbrPlayerCreated == 0 ) { detail = "er" } else { detail = "ème" }
            nbrPlayerCreated += 1
            print("** Ajout du \(nbrPlayerCreated)\(detail) joueur **")
            addPlayer()
        }
        if (maximumNbrOfPlayer != -1) {
            while (nbrPlayerCreated < maximumNbrOfPlayer && addAditionalPlayer( nbrPlayerCreated : nbrPlayerCreated)){}
        }
        else {
            while(addAditionalPlayer(nbrPlayerCreated : nbrPlayerCreated)) { nbrPlayerCreated += 1 }
        }
    }
    
    func addAditionalPlayer(nbrPlayerCreated : Int) -> Bool {
        
        print("\nSi vous souhaitez ajouter un nouveau joueur, entrez 'n'.\nSinon entrez n'importe quelle autre valeur alphanumérique.")
        let command : String = getGivenValue()
        if (command == "n") { // 'n' for new
            print("** Ajout du \(nbrPlayerCreated + 1)eme joueur **")
            addPlayer()
            return true
        }
        return false
    }
    
    func addPlayer() { // CamelCase
        print("Veuillez entrer le nom du joueur:")
        let pseudoPlayer : String = newPseudo() // The pseudo's player
        print("\(pseudoPlayer) a à présent à créer \(nbrOfCharacterPerTeam) personnages pour constituer son équipe.")
        players.append(Player(name : pseudoPlayer, teamPlayer : []))
        createTeam(owner: players[players.count-1])
        print("\nLe joueur " + pseudoPlayer + " a été ajouté au jeu.\nVoici la constitution de son équipe:")
        for tmp in players[players.count-1].team {
            print("- " + tmp.name + ", " + String(describing: type(of: tmp)) + ".")
        }
        print("\n")
    }
    
    func createTeam (owner : Player) {
        for i in 1...nbrOfCharacterPerTeam {
            var detail : String
            if( i==1 ) { detail = "er" } else { detail = "ème" }
            print("\n-- \(i)" + detail + " personnage -- ")
            let characterTmp : Character = createCharacter()
            owner.team.append(characterTmp) // Create the (3) characters for the player's team
        }
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
            case 1:
                print("Le combattant \(nameOfCharacter) a été crée et sera ajouté à votre équipe.")
                tmpCharacter = Combattant(name: nameOfCharacter)
            case 2:
                tmpCharacter = Mage(name: nameOfCharacter)
                print("Le mage \(nameOfCharacter) a été crée et sera ajouté à votre équipe.")
            case 3:
                tmpCharacter = Colosse(name: nameOfCharacter)
                print("Le colosse \(nameOfCharacter) a été crée et sera ajouté à votre équipe.")
            case 4:
                tmpCharacter = Nain(name: nameOfCharacter)
                print("Le nain \(nameOfCharacter) a été crée et sera ajouté à votre équipe.")
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
                print("Le pseudo \(given) est utilisé par un joueur, veuillez en entrez un autre svp:")
                return false
            }
            for character in one.team {
                if character.name == given {
                    print("Le pseudo \(given) est utilisé par un personnage, veuillez en entrez un autre svp:")
                    return false
                }
            }
        }
        return true
    }
}
