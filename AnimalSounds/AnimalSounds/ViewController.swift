//
//  ViewController.swift
//  AnimalSounds
//
//  Created by 이형주 on 2022/05/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var animalSoundLabel: UILabel!
    
    @IBAction func catButtonTapped(_ sender: Any) {
        animalSoundLabel.text = "Meow"
        let meowSound = SimpleSound(named: "meow")
        meowSound.play()
    }
    @IBAction func dogButtonTapped(_ sender: Any) {
        animalSoundLabel.text = "Woof"
        let woofSound = SimpleSound(named: "woof")
        woofSound.play()

    }
    @IBAction func cowButtonTapped(_ sender: Any) {
        animalSoundLabel.text = "Moo"
        let mooSound = SimpleSound(named: "moo")
        mooSound.play()
    }
    

}

