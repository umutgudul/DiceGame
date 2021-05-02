//
//  ViewController.swift
//  DiceGame
//
//  Created by UMUT GUDUL on 2.05.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblGamer1Score: UILabel!
    @IBOutlet weak var lblGamer2Score: UILabel!
    @IBOutlet weak var lblGamer1Point: UILabel!
    @IBOutlet weak var lblGamer2Point: UILabel!
    @IBOutlet weak var imgGamer1State: UIImageView!
    @IBOutlet weak var imgGamer2State: UIImageView!
    @IBOutlet weak var imgDice1: UIImageView!
    @IBOutlet weak var imgDice2: UIImageView!
    @IBOutlet weak var lblSetResult: UILabel!
    var gamerPoints = (firstGamerPoint : 0 , secondGamerPoint : 0)
    var gamerScores = (firstGamerScore : 0 , secondGamerScore : 0)
    var rowOfGamer : Int = 1
    var maxNumberofSets : Int = 5
    var currentSet : Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let background = UIImage(named: "arkaPlan"){
            self.view.backgroundColor = UIColor(patternImage: background)
        }
        
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if currentSet > maxNumberofSets {
            return
        }
        
        generateDiceValues()
        
    }
    func setResult(dice1 : Int, dice2: Int){
        if rowOfGamer == 1 {
            // new set began
            gamerPoints.firstGamerPoint = dice1 + dice2
            lblGamer1Point.text = String(gamerPoints.firstGamerPoint)
            imgGamer1State.image = UIImage(named: "bekle")
            imgGamer2State.image = UIImage(named: "onay")
            lblSetResult.text = "Sıra 2. Oyuncuda"
            rowOfGamer = 2
            lblGamer2Point.text = "0"
        } else {
            gamerPoints.secondGamerPoint = dice1 + dice2
            lblGamer2Point.text = String(gamerPoints.secondGamerPoint)
            imgGamer2State.image = UIImage(named: "bekle")
            imgGamer1State.image = UIImage(named: "onay")
            rowOfGamer = 1
            // time to finish set
            if gamerPoints.firstGamerPoint > gamerPoints.secondGamerPoint {
                // first gamer won
                gamerScores.firstGamerScore += 1
                lblSetResult.text = "\(currentSet). Seti 1. Oyuncu Kazandı"
                currentSet += 1
                lblGamer1Score.text = String(gamerScores.firstGamerScore)
            } else if gamerPoints.secondGamerPoint > gamerPoints.firstGamerPoint {
                gamerScores.secondGamerScore += 1
                lblSetResult.text = "\(currentSet). Seti 2. Oyuncu Kazandı"
                currentSet += 1
                lblGamer2Score.text = String(gamerScores.secondGamerScore)
            } else {
                // the game is a draw
                // current set musn't be changed
                lblSetResult.text = "\(currentSet). Set Berabere Sona Erdi"
                
            }
            gamerPoints.firstGamerPoint = 0
            gamerPoints.secondGamerPoint = 0
            
        }
        
        
        
        
    }
    func generateDiceValues () {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            let dice1 = arc4random_uniform(6) + 1
            let dice2 = arc4random_uniform(6) + 1
            self.imgDice1.image = UIImage(named: String(dice1))
            self.imgDice2.image = UIImage(named: String(dice2))
            self.setResult(dice1: Int(dice1), dice2: Int(dice2))
            if self.currentSet > self.maxNumberofSets {
                if self.gamerScores.firstGamerScore > self.gamerScores.secondGamerScore {
                    self.lblSetResult.text = "Oyunun Galibi 1. Oyuncu"
                } else {
                    self.lblSetResult.text = "Oyunun Galibi 2. Oyuncu"
                }
            }
        }
        lblSetResult.text = "\(rowOfGamer). Oyuncu için Zar Değeri Üretiliyor"
        imgDice1.image = UIImage(named: "bilinmeyenZar")
        imgDice2.image = UIImage(named: "bilinmeyenZar")
    }

}

