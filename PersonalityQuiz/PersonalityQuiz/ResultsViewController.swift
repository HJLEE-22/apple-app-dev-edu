//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by 이형주 on 2022/06/03.
//

import UIKit

class ResultsViewController: UIViewController {
    
    
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityResult()
    }
    
    var responses: [Answer]!
    
    func calculatePersonalityResult() {
        var frequencyOfAnswers : [Animaltype: Int] = [:]
        let responseTypes = responses.map { $0.type }
        for response in responseTypes {
            let newCount: Int
            if let oldCount = frequencyOfAnswers[response]{
                newCount = oldCount + 1
            } else {
                newCount = 1
            }
            frequencyOfAnswers[response] = newCount
        }
        let frequentAnswersSorted = frequencyOfAnswers.sorted(by:
        {(pair1, pair2) -> Bool in
            return pair1.value > pair2.value
        })
        let mostCommonAnswer = frequentAnswersSorted.first!.key
        resultAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)"
        resultDefinitionLabel.text = mostCommonAnswer.definition
        print("mostCommonAnswer",mostCommonAnswer)
    }


}
