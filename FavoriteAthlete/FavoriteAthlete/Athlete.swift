//
//  Athlete.swift
//  FavoriteAthlete
//
//  Created by 이형주 on 2022/06/08.
//

import Foundation


struct Athlete {
    var name: String
    var age: Int
    var league: String
    var team: String
    var description: String {
        return "\(name) is \(age) years old and plays for the \(team) in the \(league)"
    }

}
