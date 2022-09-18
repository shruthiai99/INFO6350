//
//  ViewController.swift
//  Multiplicator
//
//  Created by Shruthi A on 9/18/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Number1: UITextField!
    @IBOutlet weak var Number2: UITextField!
    @IBOutlet weak var TitleLabel: UILabel!
    
    @IBOutlet weak var ResultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func MultiplyButton(_ sender: Any) {
        let num1 = Int(Number1.text!)
        let num2 = Int(Number2.text!)
        let result = num1! * num2!
        ResultLabel.text = String(result)
    }
    
}

