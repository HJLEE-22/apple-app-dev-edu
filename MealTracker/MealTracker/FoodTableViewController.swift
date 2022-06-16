//
//  FoodTableViewController.swift
//  MealTracker
//
//  Created by 이형주 on 2022/06/09.
//

import Foundation
import UIKit

class FoodTableViewController: UITableViewController {
    
    var meals: [Meal] {
        let breakfast = Meal(name: "breakfast", food: breakFastFood)
        let lunch = Meal(name: "lunch", food: lunchFood)
        let dinner = Meal(name: "dinner", food: dinnerFood)
        return [breakfast, lunch, dinner]
    }

    let breakFastFood: [Food] = [
        Food(name: "toast", description: "light"),
        Food(name: "milk", description: "good for toast"),
        Food(name: "egg", description: "for toast")
    ]
    
    let lunchFood: [Food] = [
        Food(name: "jajangmyeon", description: "heavy"),
        Food(name: "onion", description: "with choonjang sauce"),
        Food(name: "danmujee", description: "banchan for chiness food")
    ]
    
    let dinnerFood: [Food] = [
        Food(name: "blueberry", description: "with yogurt"),
        Food(name: "yogurt", description: "super light")
    ]
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

         //section 을 어떻게 다르게 받지?
        // 동적으로 받아봐~
        //meals[section].food.count
        
        if section == 0 {
            return meals[0].food.count
        } else if section == 1 {
            return meals[1].food.count
        } else if section == 2 {
            return meals[2].food.count
        } else {
            return 0 // numberOfRowsIntSection은 무조건 값이 있어야되니까 디폴트가 필요하지...
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath)
        // 섹션을 받는 법을 모르겠다...
        // -> 이제 알았다.
        cell.textLabel?.text = meals[indexPath.section].food[indexPath.row].name
        cell.detailTextLabel?.text = meals[indexPath.section].food[indexPath.row].description

    return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return meals[section].name
    }

}
