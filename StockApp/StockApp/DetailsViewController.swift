//
//  DetailsViewController.swift
//  StockApp
//
//  Created by Shruthi A on 12/10/22.
//

import UIKit

class DetailsViewController: UIViewController {
    var stock = ""

    @IBOutlet weak var lblStock: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblStock.text = stock

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
