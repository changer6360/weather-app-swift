//
//  ViewController.swift
//  WeatherAPP
//
//  Created by Tihomir Videnov on 6/28/16.
//  Copyright © 2016 Tihomir Videnov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var mainTempLbl: UILabel!
    @IBOutlet weak var childTempLbl: UILabel!
    @IBOutlet weak var windLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var backgroundImg: UIImageView!
    
    var weather: Weather!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityField.text = "London"
        weather = Weather(city: cityField.text!)
        
        
        weather.downloadWeather { () -> () in
          
           self.updateUI()
            self.cityField.text = ""
        }
    }
    
        
        func updateUI() {
            timeLbl.text = "\(weather.time) \(weather.day)"
           headerLabel.text = "\(weather.currentCity),\(weather.country)"
           descLabel.text = weather.description
           mainTempLbl.text = "\(weather.temperature)"
           childTempLbl.text = "\(weather.minTemp)/\(weather.maxTemp)"
            windLbl.text = (weather.wind)
            humidityLbl.text = "\(weather.humidity) %"
            weatherIcon.image = UIImage(named: weather.icon)
            backgroundImg.image = UIImage(named: weather.bg)
            
            
            
//        print(weather.city)
//        print(weather.country)
//        print(weather.currentCity)
//        print(weather.wind)
//        print(weather.weather)
//        print(weather.temperature)
//        print(weather.minTemp)
//        print(weather.maxTemp)
//        print(weather.icon)
//        print(weather.humidity) 
            
        }
  
    @IBAction func searchButton(sender: AnyObject) {
        
        if cityField.text == "" || weather.resultQuery == false {
            
            let optionMenu = UIAlertController(title: nil, message: "Please enter a valid city", preferredStyle: .Alert)
                //Adding actions to the menu
                 let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                 optionMenu.addAction(cancelAction)
            self.presentViewController(optionMenu, animated: true, completion: nil)
            
        } else {
            
        let city = cityField.text?.stringByReplacingOccurrencesOfString(" ", withString: "")
        weather = Weather(city: city!)
        weather.downloadWeather { () -> () in
            
            self.updateUI()
            self.view.endEditing(true)
            }
        }
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }

}

