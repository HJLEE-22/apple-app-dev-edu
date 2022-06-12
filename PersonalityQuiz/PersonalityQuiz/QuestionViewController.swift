//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by 이형주 on 2022/06/03.
//

import UIKit

class QuestionViewController: UIViewController {


    
    @IBOutlet weak var mainTitleLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!

    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    @IBOutlet weak var rangeStackView: UIStackView!
    @IBOutlet weak var rangedLabel: UILabel!
    @IBOutlet weak var rangedLabe2: UILabel!
    @IBOutlet weak var questionProgressview: UIProgressView!

    @IBOutlet weak var rangedSlider: UISlider!
    
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton!) {
        let currentAnswers = questions[questionIndex].answer
        
        switch sender {
        case singleButton1 :
            answerChosen.append(currentAnswers[0])
        case singleButton2 :
            answerChosen.append(currentAnswers[1])
        case singleButton3 :
            answerChosen.append(currentAnswers[2])
        case singleButton4 :
            answerChosen.append(currentAnswers[3])
        default :
            break
        }
        nextQuestion()
    }
    
    
    @IBAction func multipleAnswerButtonPressed(){
        let currentAnswers = questions[questionIndex].answer
        
        if multiSwitch1.isOn {
            answerChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn {
            answerChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn {
            answerChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn {
            answerChosen.append(currentAnswers[3])
        }
        nextQuestion()
    }
    

    
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answer
        let index = Int(rangedSlider.value * Float(currentAnswers.count - 1))
//        print("rangedSlider.value", rangedSlider.value)
//        print("currentAnswers.count", currentAnswers.count)
        answerChosen.append(currentAnswers[index])
     // 저게 뭘 위한 식이지? 왜 index에서 1 빼는거지?
        // -> 레인지의 값은 0-1, 내가 원하는 answer의 index는 0-3까지. 즉 answer의 총 개수에 -1을 하고 레인지의 값에 곱하면 저 값이 나온다.
        
        nextQuestion()
    }
    
    func nextQuestion() {
        questionIndex += 1
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    var questionIndex = 0
    var answerChosen: [Answer] = []
    
    var questions: [Question] = [
        Question(text: "Which food do you like the most?",
                 type: .single,
                 answer: [
                    Answer(text: "Steak", type: .dog),
                    Answer(text: "Fish", type: .cat),
                    Answer(text: "Carrot", type: .rabbit),
                    Answer(text: "Corn", type: .turtle)
                 ]),
        Question(text: "Which activies do you enjoy?",
                 type: .multiple,
                 answer: [
                    Answer(text: "Swimming", type: .turtle),
                    Answer(text: "Sleeping", type: .cat),
                    Answer(text: "Cuddling", type: .rabbit),
                    Answer(text: "Eating", type: .dog)
                         ]),
        Question(text: "How much do you enjoy car rides?",
                 type: .ranged,
                 answer: [
                    Answer(text: "I love them", type: .dog),
                    Answer(text: "I dislike them", type: .cat),
                    Answer(text: "I get a little nervous", type: .rabbit),
                    Answer(text: "I barely notice them", type: .turtle)
                         ])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

        
    }
    
    func updateUI(){
        
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangeStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswer = currentQuestion.answer
        let totalProgress = Float(questionIndex) / Float(questions.count)
        // 밑에서 totalProgress를 Float처리 안하고 먼저 하는 이유가 있을까?
        // Float처리 여기서 안하면 소숫점이 무시된다더라.
        // 근데 소숫점이 왜 필요하나요?
        // 그니까, 1/3은 플롯처리 하기 이전에 Int로 0이 되는거지.
//        print("바로Float", Float(questionIndex / questions.count))
//        print("따로Float", totalProgress )
        // 왜 Float 처리가 필요한지는 알지? 슬라이더의 setProgress 메소드가 float 값 받기 때문.
        
        mainTitleLabel.text = currentQuestion.text
        navigationItem.title = "Question #\(questionIndex + 1)"
        questionProgressview.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single :
            updateSingleStack(using: currentAnswer)
        case .multiple :
            updateMultipleStack(using: currentAnswer)
        case .ranged :
            updateRangedStack(using: currentAnswer)
            // storyboard에서 체크한 installed 해제 안하면 작동 안함.
        }
        
        

    }
    
    func updateSingleStack(using answer: [Answer]){
        singleStackView.isHidden = false
        singleButton1.setTitle(answer[0].text, for: .normal)
        singleButton2.setTitle(answer[1].text, for: .normal)
        singleButton3.setTitle(answer[2].text, for: .normal)
        singleButton4.setTitle(answer[3].text, for: .normal)
    }
    
    func updateMultipleStack(using answer: [Answer]){
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        multiLabel1.text = answer[0].text
        multiLabel2.text = answer[1].text
        multiLabel3.text = answer[2].text
        multiLabel4.text = answer[3].text
    }

    func updateRangedStack(using answer: [Answer]){
        rangeStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel.text = answer.first?.text
        rangedLabe2.text = answer.last?.text
        // 텍스트 부분 이해 안감...
        // 보면, 레인지 슬라이더의 양 끝에만 텍스트를 사용했음. 즉 양 끝의 값에 해당하는 텍스트만 사용할 것이기 때문에, 인자값으로 받은 currentAnswer(quenstions의 두 번째 질문의 answer들) 중 first와 last만 사용하게 되었다. 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answerChosen
        }
    }
    
}
