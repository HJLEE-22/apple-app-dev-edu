//
//  ViewController.swift
//  MemeMaker
//
//  Created by 이형주 on 2022/05/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        topCaptionSegmentedControl.removeAllSegments()


    }

    @IBOutlet weak var topCaptionSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var bottomCaptionSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var topCaptionLabel: UILabel!
    
    @IBOutlet weak var bottomCaptionLabel: UILabel!

    @IBAction func SegmentedControlBtn(_ sender: UISegmentedControl) {
        for choice in topEmojis {
            topCaptionSegmentedControl.insertSegment(withTitle: topEmojis, at: topEmojis.count, animated: false)
        }
        topCaptionSegmentedControl.selectedSegmentIndex = 0
    }
    
    let topEmojis = ["🕶", "💥", "💕"]
    let bottomEmojis = ["🐱", "🦮", "🐒"]
    
    let segmentedControl = UISegmentedControl(items: self.topEmojis)
    
    
    let topChoices: [CaptionOption] = {
//        let emoji = ["🕶", "💥", "💕"]
//        let caption = ["You know what's cool?", "You know what makes me mad?", "You know what I love?"]
//        CaptionOption.init(emoji: emoji[index], caption: caption[index])
        
        switch emoji {
        case "🕶" :
            return caption = "You know what's cool?"
        case "💥" :
            return caption = "You know what makes me mad?"
        case "💕" :
            return caption = "You know what I love?"
        }
    }
    
    
    
    let bottomChoices: [CaptionOption] = {
        switch emoji {
        case "🐱" :
            return caption = "Cats wearing hats"
        case "🦮" :
            return caption = "Dogs carrying logs"
        case "🐒" :
            return caption = "Monkeys being funky"
        }
    }
    
    
}

