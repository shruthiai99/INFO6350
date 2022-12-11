//
//  ViewController.swift
//  StockApp
//
//  Created by Shruthi A on 12/10/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var stocks = [String]()
    var indexSelected = 0
    
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadStocks()
    }
    
    func loadStocks(){
        let url = "https://us-central1-whatsapp-analytics-2de0e.cloudfunctions.net/app/allstocks"
        AF.request(url).responseJSON{ responseData in
            if responseData.error != nil{
                print(responseData.error)
                return
            }
            let stockData = JSON(responseData.data as Any)
            
            //            let stockValues = stockData["CompanyName"] + "," + stockData["Symbol"] + "," + stockData["Price"]
            for data in stockData{
                let stockJSON = JSON(data.1)
                let companyName = stockJSON["CompanyName"].stringValue
                let symbol = stockJSON["Symbol"].stringValue
                let price = stockJSON["Price"].stringValue
                let str = companyName + " " + symbol + " " + price
                print(str)
                self.stocks.append(str)
            }
            self.tblView.reloadData()
            
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = stocks[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexSelected = indexPath.row
        performSegue(withIdentifier: "segueDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segueDetails"){
            let destVC = segue.destination as! DetailsViewController
            let selectedStock = stocks[indexSelected]
            destVC.stock = selectedStock
        }
        
    }
}
