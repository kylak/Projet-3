//
//  Game.swift
//  jeu-video
//
//  Created by Gustav Berloty on 02/01/2019.
//  Copyright © 2019 Gustav Berloty. All rights reserved.
//

import Foundation

class GameManager {     // This class is used to add players and characters before playing with them.
    
    // MARK: PROPERTY LIST
    
    private var players : [Player]      // All the players of the game. Watch out: character and player are two different things.
    private var playersAdded : Bool     // Used by the menu to know if the user has already add the players of the game.
    private let minimumNbrOfPlayer : Int = 2        // minimum number of player
    private let maximumNbrOfPlayer : Int = 4        // maximum number of player
    private var nbrPlayerCreated : Int = 0
    private let nbrOfCharacterPerTeam : Int  = 2        // number of character per team
    private var playingTheGame : GameCore?       // To launch the game
    
    /* How the game init works :
     We add each player one per one (as many as we can)
     when we have finished to add the players, we leave the 'adding mode' using an alphanumeric character
     then we can launch the first round of the game.
     */
    
    // MARK: GETTER LIST
    
    func getPlayers() -> [Player] {  // getter (the only non private method)
        return players
    }
    
    // MARK: CONSTRUCTOR
    
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
    
    // MARK: ACTION METHODS
    
    private func menu() -> Bool {       // Display the game's menu
        if (!playersAdded) {
            print("\n### Menu du jeu ###\nPour:\n- Commencer une partie en ajoutant les joueurs et leurs personnages, entrez 'n'.\n- Avoir des informations sur le jeu, entrez 'i'.\n- Quitter le jeu, entrez n'importe quelle autre valeur alphanumérique.")
        }
        else {
            print("\n### Menu du jeu ###\nPour:\n- Lancer une partie, entrez 'l'.\n- Avoir des informations sur le jeu, entrez 'i'.\n- Quitter le jeu entrez n'importe quelle autre valeur alphanumérique.")
        }
        let option : String = readLine()!
        if (option == "n"){ // 'n' for next
            print("\n### Ajout des joueurs ###")
            addPlayers()
            continueAfterPlayersAdded()
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
    
    // MARK: 1. Add players
    
    private func addPlayers() {     // To add all players
        
        while (nbrPlayerCreated < minimumNbrOfPlayer) {
            var detail : String
            if(nbrPlayerCreated == 0 ) { detail = "er" } else { detail = "ème" }
            nbrPlayerCreated += 1
            print("** Ajout du \(nbrPlayerCreated)\(detail) joueur **")
            addPlayer()
        }
        if (maximumNbrOfPlayer != -1) {
            while (nbrPlayerCreated < maximumNbrOfPlayer && addAditionalPlayer()){}
        }
        else {
            while(addAditionalPlayer()){}
        }
    }
    
    private func addPlayer() {      // To add one player
        print("Veuillez entrer le nom du joueur:")
        let pseudoPlayer : String = newPseudo() // The pseudo's player
        print("\(pseudoPlayer) a à présent à créer \(nbrOfCharacterPerTeam) personnages pour constituer son équipe.")
        players.append(Player(name : pseudoPlayer, teamPlayer : []))
        createTeam(owner: players[players.count-1])
        print("\nLe joueur " + pseudoPlayer + " a été ajouté au jeu.\nVoici la constitution de son équipe:")
        for tmp in players[players.count-1].getTeam() {
            print("- " + tmp.getName() + ", " + String(describing: type(of: tmp)) + ".")
        }
        print("\n")
    }
    
    private func addAditionalPlayer() -> Bool {       // To add an other player
        print("\nSi vous souhaitez ajouter un nouveau joueur, entrez 'n'.\nSinon entrez n'importe quelle autre valeur alphanumérique.")
        let command : String = readLine()!
        if (command == "n") { // 'n' for new
            nbrPlayerCreated += 1
            print("** Ajout du \(nbrPlayerCreated)eme joueur **")
            addPlayer()
            return true
        }
        return false
    }
    
    // MARK: 2. Add characters
    
    private func createTeam (owner : Player) {      // To create the player's team
        for i in 1...nbrOfCharacterPerTeam {
            var detail : String
            if( i==1 ) { detail = "er" } else { detail = "ème" }
            print("\n-- \(i)" + detail + " personnage -- ")
            let characterTmp : Character = createCharacter()
            owner.addCharacterToTheTeam(this: characterTmp) // Create the (3) characters for the player's team
        }
    }
    
    private func createCharacter() -> Character {       // To create a character
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
    
    // MARK: 3. Ready to be launch
    
    private func continueAfterPlayersAdded() {       // Display all the players added
        playersAdded = true
        print("L'ajout de joueur est terminé.\nOnt été enregsitré les joueurs suivant: ")
        for tmp in players { print("- " + tmp.getPseudo()) }
        print("")
    }
    
    private func play () {      // Once all players are added launch the game !
        playingTheGame = GameCore(game: self)
        playingTheGame?.start()
    }
    
    // MARK: OTHER
    // MARK: Get pseudos
    
    private func newPseudo() -> String {        // Get an unique string as name from the user
        var pseudo : String
        repeat { pseudo = getGivenValue() } while !isUnique(given: pseudo)
        return pseudo
    }
    
    private func getGivenValue() -> String {        // Get a string, often use as name, from the user.
        var name : String?
        name = readLine()
        while (name == nil || (name!).count < 3 || (name!).rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil) {
            print("Veuillez n'entrer que des caractères alphanumériques et 3 au minimum.")
            name = readLine()
        }
        return name!
    }
    
    private func isUnique(given : String) -> Bool {     // Check the unicity of a string among all players and all characters in the game.
        for one in players {
            if one.getPseudo() == given {
                print("Le pseudo \(given) est utilisé par un joueur, veuillez en entrez un autre svp:")
                return false
            }
            for character in one.getTeam() {
                if character.getName() == given {
                    print("Le pseudo \(given) est utilisé par un personnage, veuillez en entrez un autre svp:")
                    return false
                }
            }
        }
        return true
    }
}
