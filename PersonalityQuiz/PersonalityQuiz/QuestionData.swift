//
//  QuestionData.swift
//  PersonalityQuiz
//
//  Created by 이형주 on 2022/06/03.
//

import Foundation

struct Question {
    var text: String
    var type: ResponseType
    var answer: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: Animaltype
}

enum Animaltype: Character {
    case dog = "🐶", cat = "🐱", rabbit = "🐰", turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog :
            return "You are incredibly outgoing. You surround yourself with the people you love and enjoy activities with your friends."
        case .cat :
            return "Mischievous, yet mild-tempered, you enjoy doing things on your own term."
        case .rabbit :
            return "You love everything that's soft. You are healthy and full of energy."
        case .turtle :
            return "You are wise beyond your years, and you focused on your details. Slow and steady wins the race."
        }
    }
}

