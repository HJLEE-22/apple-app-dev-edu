//
//  ViewController.swift
//  Contest
//
//  Created by 이형주 on 2022/07/20.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBAction func submit(_ sender: UIButton) {
        if emailTextField.hasText {
            performSegue(withIdentifier: "whatTheSegue", sender: nil)
        } else {
            UIView.animate(withDuration: 0.25, animations: {
                self.emailTextField.transform = CGAffineTransform(translationX: 10, y: 0)
            }) { (_) in
                self.emailTextField.transform = CGAffineTransform.identity
            }
        }
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

