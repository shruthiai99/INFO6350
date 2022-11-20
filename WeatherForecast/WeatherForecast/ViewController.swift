//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Shruthi A on 11/19/22.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var cityTxt: UITextField!
    
    let locationManager = CLLocationManager()
    var lat: CLLocationDegrees?
    var lng: CLLocationDegrees?
    var temps = [String]()


    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print(error)
       }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        lat = location.coordinate.latitude
        lng = location.coordinate.longitude
        
        print(lat)
        print(lng)
        
        
    }
    
    @IBAction func getCurrenLoc(_ sender: Any) {
        var url = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/weatherdata/forecast?locations="
        url += String(format: "%f", lat!) + "," + String(format: "%f", lng!) + "&aggregateHours=24&unitGroup=us&shortColumnNames=false&contentType=json&key=AYQR6QM5KHFYVPH9M4EXXJUCC"

        AF.request(url).responseJSON { responseData in

            if responseData.error != nil {
                print(responseData.error!)
                return
            }
            let weatherData = JSON(responseData.data as Any)

            let forecastValues =  weatherData["locations"][String(format: "%f", self.lat!) + "," + String(format: "%f", self.lng!)]["values"]
            print(forecastValues.count)

            self.temps = [String]()
            for forecast in forecastValues {
                print(forecast)

                let forecastJSON = JSON(forecast.1)
                let temp = forecastJSON["temp"].floatValue
                let condition = forecastJSON["conditions"].stringValue
                let str = "Temperature = \(temp)℉, \(condition)"
                self.temps.append(str)
            }
            self.tblView.reloadData()


        }
        
    }
    
    
    @IBAction func getWeather(_ sender: Any) {
        let cityName = cityTxt.text!
        var url = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/weatherdata/forecast?locations="
        url +=  cityName + "&aggregateHours=24&unitGroup=us&shortColumnNames=false&contentType=json&key=AYQR6QM5KHFYVPH9M4EXXJUCC"

        AF.request(url).responseJSON { responseData in

            if responseData.error != nil {
                print(responseData.error!)
                return
            }
            let weatherData = JSON(responseData.data as Any)
            let forecastValues =  weatherData["locations"][self.cityTxt.text!]["values"]
            print(forecastValues.count)

            self.temps = [String]()
            for forecast in forecastValues {
                print(forecast)

                let forecastJSON = JSON(forecast.1)
                let temp = forecastJSON["temp"].floatValue
                let condition = forecastJSON["conditions"].stringValue
                let str = "Temperature = \(temp)℉, \(condition)"
                self.temps.append(str)
            }
            self.tblView.reloadData()


        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = temps[indexPath.row]
        return cell
    }
}

