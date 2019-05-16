//
//  Game.swift
//  Apple Pie
//
//  Created by ebukaa on 21/04/2018.
//  Copyright © 2018 ebukaa. All rights reserved.
//

import Foundation
// helpful to hold the state of the game inside of a Game struct.
struct Game {
    var word:String
    var incorrectMovesRemaining:Int
    var guessedLetters:[Character]
    
    var formattedWord:String {
        var guessedWord = ""
        
        for letter in word {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
    
    mutating func playerGuessed(letter:Character){
        guessedLetters.append(letter)
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
        }
    }
}
