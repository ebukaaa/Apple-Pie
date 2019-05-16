//
//  ViewController.swift
//  Apple Pie
//
//  Created by ebukaa on 21/04/2018.
//  Copyright © 2018 ebukaa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tree: UIImageView!
    @IBOutlet weak var correctWord: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet var letters: [UIButton]!
    
    var listOfWords = ["buccaneer", "swift", "glorious",
    "incandescent", "bug", "program"]
    
    let incorrectMovesAllowed = 7
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newRound()
    }
    var currentGame:Game!
    
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            
            enableLetters(true)
            updateUI()
        } else {
            enableLetters(false)
        }
    }
    func enableLetters(_ enable:Bool) {
        for button in letters {
            button.isEnabled = enable
        }
    }
    func updateUI() {
        var alphabets = [String]()
        
        for letter in currentGame.formattedWord {
            alphabets.append(String(letter))
        }
        let wordWithSpacing = alphabets.joined(separator: " ")
        
        correctWord.text = wordWithSpacing
        score.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        tree.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        
        let letterString = sender.title(for: .normal)!
        let alphabet = Character(letterString.lowercased())
        
        currentGame.playerGuessed(letter: alphabet)
        updateGameState()
    }
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.formattedWord == currentGame.word {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
}

