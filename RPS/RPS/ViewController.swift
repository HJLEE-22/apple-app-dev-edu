//
//  ViewController.swift
//  RPS
//
//  Created by 이형주 on 2022/05/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        playAgainOutlet.isHidden = true
    }

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var statusOfGame: UILabel!
    @IBOutlet weak var fist: UIButton!
    @IBOutlet weak var palm: UIButton!
    @IBOutlet weak var victory: UIButton!
    
    @IBOutlet weak var playAgainOutlet: UIButton!
    
    @IBAction func rockBtn(_ sender: Any) {
        fist.isHidden = false
        palm.isHidden = true
        victory.isHidden = true
        
        let clickedSign: Sign = .rock
        let computerSign: Sign = randomSign()
        let resultOfRPS = clickedSign.match(opponent: computerSign)
        
        if resultOfRPS == .win {
            view.backgroundColor = .green
            statusOfGame.text = "You win!"
        } else if resultOfRPS == .lose {
            view.backgroundColor = .red
            statusOfGame.text = "You lose!"
        } else {
            view.backgroundColor = .blue
            statusOfGame.text = "Draw. Try Again"
        }
        
        topLabel.text = computerSign.emoji
        playAgainOutlet.isHidden = false
        
//        switch resultOfRPS {
//        case .win :
//            return view.backgroundColor = .green
//        case .lose :
//            return view.backgroundColor = .blue
//        case .draw :
//            return view.backgroundColor = .red
//        case .start :
//            return view.backgroundColor = .gray
//        }
    }
    
    @IBAction func paperBtn(_ sender: Any) {
        fist.isHidden = true
        palm.isHidden = false
        victory.isHidden = true
        
        let clickedSign: Sign = .paper
        let computerSign: Sign = randomSign()
        let resultOfRPS = clickedSign.match(opponent: computerSign)
        
        if resultOfRPS == .win {
            view.backgroundColor = .green
            statusOfGame.text = "You win!"
        } else if resultOfRPS == .lose {
            view.backgroundColor = .red
            statusOfGame.text = "You lose!"
        } else {
            view.backgroundColor = .blue
            statusOfGame.text = "Draw. Try Again"
        }
        
        topLabel.text = computerSign.emoji
        playAgainOutlet.isHidden = false
    }
    
    @IBAction func scissorsBtn(_ sender: Any) {
        fist.isHidden = true
        palm.isHidden = true
        victory.isHidden = false
        
        let clickedSign: Sign = .scissors
        let computerSign: Sign = randomSign()
        let resultOfRPS = clickedSign.match(opponent: computerSign)
        
        if resultOfRPS == .win {
            view.backgroundColor = .green
            statusOfGame.text = "You win!"
        } else if resultOfRPS == .lose {
            view.backgroundColor = .red
            statusOfGame.text = "You lose!"
        } else {
            view.backgroundColor = .blue
            statusOfGame.text = "Draw. Try Again"
        }
        
        topLabel.text = computerSign.emoji
        playAgainOutlet.isHidden = false
        }

    
    @IBAction func PlayAgainBtn(_ sender: Any) {
        view.backgroundColor = .gray
        playAgainOutlet.isHidden = true
        fist.isHidden = false
        palm.isHidden = false
        victory.isHidden = false
        topLabel.text = "🤡"
        statusOfGame.text = "Rock, Paper, Scissors?"
    }
    


    
}


// 질문1.
// 결과 페이지에서 palm 만 위치가 중앙정렬 안됨.

// 질문2.
// 결과 페이지에서 남아있는 이모지 터치 시 배경색 계속 바뀜.
